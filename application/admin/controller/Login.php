<?php

namespace app\admin\controller;

use app\admin\model\ErrorCode;
use app\common\model\Admin;
use app\common\model\AuthRule;
use app\common\model\RoleAdmin;

/**
 * 登录
 */

class Login extends Base
{
    /**
     * 获取用户信息
     * @return \think\response\Json
     */
    public function index()
    {

        if (!request()->isPost()){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }

        $user_name = request()->post('userName');
        $pwd = request()->post('pwd');

        if (!$user_name || !$pwd){
            $res = [];
            $res['errcode'] = ErrorCode::$VALIDATION_FAILED;
            $res['errmsg'] = 'username 不能为空。 password 不能为空。';
            return json($res);
        }
        $admin = Admin::where('username',$user_name)
            ->field('id,username,avatar,password,status')
            ->find();

        if (empty($admin) || Admin::getPass($pwd) != $admin->password){
            $res = [];
            $res['errcode'] = ErrorCode::$USER_AUTH_FAIL;
            $res['errmsg'] = '用户名或者密码错误';
            return json($res);
        }
        if ($admin->status != 1){
            $res = [];
            $res['errcode'] = ErrorCode::$USER_NOT_PERMISSION;
            $res['errmsg'] = '当前没有权限登录，联系管理员';
            return json($res);
        }

        $info = $admin->toArray();
        unset($info['password']);

        // 权限信息
        $roles = [];
        if ($user_name == 'admin'){
            $roles = ['admin'];
        }else{
            $role_user_list = RoleAdmin::where('admin_id',$admin->id)
                ->field('role_id')
                ->select();
            if ($role_user_list){
                $role_ids = array_column($role_user_list->toArray(),'role_id');
                $auth_rule_ids = AuthAccess::where('role_id','in',$role_ids)
                    ->field(['auth_rule_id'])
                    ->select();
                foreach ($auth_rule_ids as $key=>$val){
                    $name = AuthRule::where('id',$val['auth_rule_id'])->value('name');
                    if ($name){
                        $roles = [];
                    }
                }
            }
        }
        $info['roles'] = $roles;
        $info['roles'] = [
            'user_manage',
            'user_manage/admin',
            'admin/admin/index',
            'admin/role/index',
            'admin/authRule/index',
        ];
        // 保存用户信息
        $res = Admin::loginInfo($info['id'],$info);
        $res['id'] = !empty($res['id']) ? intval($res['id']) : 0;
        $res['avatar'] = !empty($res['avatar']) ? Admin::getAvatarUrl($res['avatar']) : '';
        return json($res);
    }

    /**
     * 获取登录用户信息
     * @return \think\response\Json
     */
    public function userInfo()
    {
        $id = request()->header('X-Adminid');
        $token = request()->header('X-Token');
        if (!$id || !$token) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }
        $res = Admin::loginInfo($id, (string)$token);
        $res['id'] = !empty($res['id']) ? intval($res['id']) : 0;
        $res['avatar'] = !empty($res['avatar']) ? Admin::getAvatarUrl($res['avatar']) : '';
        // $res['roles'] = ['admin'];
        return json($res);
    }

    /**
     * 退出
     * @return \think\response\Json
     */
    public function out()
    {
        if (!request()->isPost()){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }

        $id = request()->post('id');
        $token = request()->post('token');
        if (!$id || !$token) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }
        $loginInfo = Admin::loginInfo($id,(string)$token);
        if ($loginInfo == false){
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }

        Admin::loginOut($id);

        return 'SUCCESS';

    }


    public function s(){
        $loginInfo = Admin::loginInfo(2,'eyJpZHNzIjoiJDJ5JDEwJGRtYTh0S3diWHpqeHJsYTJ5R3dHd2VrSVRON3g0SEhzUENEdVdcL3kxeVVta0RjVlE3NDNidSJ9_2017-11-27');
        dump($loginInfo);
    }
}
