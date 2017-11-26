<?php

namespace app\admin\controller;

/**
 * 用户相关
 */

class User extends Base
{

    public function initialize()
    {
        parent::initialize();
        header('Access-Control-Allow-Origin:*');
        header('Access-Control-Allow-Methods:GET,POST,PUT,DELETE,PATCH,OPTIONS');
        header('Access-Control-Allow-Headers:Content-Type, X-ELEME-USERID, X-Eleme-RequestID, X-Shard,X-Shard, X-Eleme-RequestID');
    }

    /**
     * 获取用户信息
     * @return \think\response\Json
     */
    public function read()
    {
        $uid = request()->post('uid');

        $token = request()->post('token');

        $res['uid'] = 1;
        $res['userName'] = 'userName';
        $res['avatar'] = 'avatar';
        $res['token'] = 'token';
        $res['roles'] = ['admin'];
        return json($res);
    }

    /**
     * 登录
     * @return \think\response\Json
     */
    public function login()
    {
        $user_name = request()->post('userName');
        $pwd = request()->post('pwd');

        $res['uid'] = 1;
        $res['userName'] = $user_name;
        $res['avatar'] = 'avatar';
        $res['token'] = 'token';
        $res['roles'] = ['admin'];
        return json($res);
    }
}
