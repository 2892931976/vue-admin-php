<?php

namespace app\admin\controller;

use app\admin\model\ErrorCode;
use app\common\model\Admin;
use app\common\model\AuthAccess;
use app\common\model\AuthRule;
use app\common\model\RoleAdmin;
use think\Controller;

/**
 * 用户基础控制器
 */

class BaseCheckUser extends Base
{

    public $adminInfo = '';

    public function initialize()
    {
        parent::initialize();
        $id = request()->header('X-Adminid');
        $token = request()->header('X-Token');
        if (!$id || !$token) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            echo json_encode($res);exit;
        }
        $info = Admin::loginInfo($id, (string)$token);
        if ($info == false) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            echo json_encode($res);exit;
        }
        $this->adminInfo = $info;
        // 排除权限
        $not_check = ['admin/index/index', 'admin/main/index', 'admin/system/clear'];

        //检查权限
        $module     = request()->module();
        $controller = request()->controller();
        $action     = request()->action();
        $rule_name = strtolower($module . '/' . $controller . '/' . $action);
        // 不在排除的权限内，并且 用户不为超级管理员
        if (!in_array(strtolower($rule_name), $not_check) && (empty($info['username']) || $info['username'] != 'admin')) {
            $auth_rule_names = isset($info['authRules']) && is_array($info['authRules']) ? $info['authRules'] : [];
            if (!self::check($info, $auth_rule_names, [$rule_name],'and')){
                $res = [];
                $res['errcode'] = ErrorCode::$AUTH_FAILED;
                $res['errmsg'] = '权限验证失败';
                echo json_encode($res);exit;
            }
        }

    }

    /**
     * 检查权限
     * @param array $admin 管理员信息
     * @param  array $auth_rule_names 管理员id
     * @param array  $name 需要验证的规则列表,支持逗号分隔的权限规则或索引数组
     * @param string $relation 如果为 'or' 表示满足任一条规则即通过验证;如果为 'and'则表示需满足所有规则才能通过验证
     * @return bool 通过验证返回true;失败返回false
     */
    public static function check($admin, $auth_rule_names = [], $name = [], $relation = 'or'){

        if (empty($auth_rule_names) || empty($name)){
            return false;
        }

        if (is_string($name)) {
            $name = strtolower($name);
            if (strpos($name, ',') !== false) {
                $name = explode(',', $name);
            } else {
                $name = array($name);
            }
        }
        $auth_rule_list = AuthRule::where('name','in',$auth_rule_names)
            ->field('id,name,condition')
            ->select();

        $list = [];
        foreach ($auth_rule_list as $rule){
            if (!empty($rule['condition'])) { //根据condition进行验证
                $admin = $admin; // $admin 不能删除，下面正则会用到
                $command = preg_replace('/\{(\w*?)\}/', '$admin[\'\\1\']', $rule['condition']);
                //dump($command);//debug
                @(eval('$condition=(' . $command . ');'));
                if ($condition) {
                    $list[] = strtolower($rule['name']);
                }
            }else{
                $list[] = strtolower($rule['name']);
            }
        }

        if ($relation == 'or' and !empty($list)) {
            return true;
        }
        $diff = array_diff($name, $list);
        if ($relation == 'and' and empty($diff)) {
            return true;
        }

        return false;

    }

}
