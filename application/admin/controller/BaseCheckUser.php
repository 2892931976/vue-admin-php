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
        $res = Admin::loginInfo($id, (string)$token);
        if ($res == false) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            echo json_encode($res);exit;
        }
        $this->adminInfo = $res;

        // 排除权限
        $not_check = ['admin/index/index', 'admin/main/index', 'admin/system/clear'];

        //检查权限
        $module     = request()->module();
        $controller = request()->controller();
        $action     = request()->action();
        $rule_name = strtolower($module . '/' . $controller . '/' . $action);
        if (!in_array(strtolower($rule_name), $not_check)) {
            $auth_rule_names = isset($res['roles']) && is_array($res['roles']) ? $res['roles'] : [];
            if (!self::check($auth_rule_names, [$rule_name],'and')){
                $res = [];
                $res['errcode'] = ErrorCode::$AUTH_FAILED;
                $res['errmsg'] = '权限验证失败';
                echo json_encode($res);exit;
            }
        }

    }

    /**
     * 检查权限
     * @param  int $admin_id 管理员id
     * @param array  $name 需要验证的规则列表,支持逗号分隔的权限规则或索引数组
     * @param string $relation 如果为 'or' 表示满足任一条规则即通过验证;如果为 'and'则表示需满足所有规则才能通过验证
     * @return bool 通过验证返回true;失败返回false
     */
    public static function check($auth_rule_names = [], $name = [], $relation = 'or'){

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

                $command = preg_replace('/\{(\w*?)\}/', '$user[\'\\1\']', $rule['condition']);
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
