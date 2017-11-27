<?php

namespace app\admin\controller;

use app\admin\model\ErrorCode;
use \app\common\model\Admin as AdminModel;

/**
 * 管理员相关
 */

class Admin extends Base
{
    /**
     * 获取用户信息
     * @return \think\response\Json
     */
    public function read()
    {
        $id = request()->get('id');
        $token = request()->get('token');
        if (!$id || !$token) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }
        $res = AdminModel::loginInfo($id,(string)$token);
        if ($res == false){
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }
        $res['id'] = !empty($res['id']) ? intval($res['id']) : 0;
        $res['avatar'] = !empty($res['avatar']) ? Admin::getAvatarUrl($res['avatar']) : '';
        $res['roles'] = ['admin'];
        return json($res);
    }
}
