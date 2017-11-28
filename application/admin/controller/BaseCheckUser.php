<?php

namespace app\admin\controller;

use app\admin\model\ErrorCode;
use app\common\model\Admin;
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
        $id = request()->get('id');
        $token = request()->get('token');
        if (!$id || !$token) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }
        $res = Admin::loginInfo($id, (string)$token);
        if ($res == false) {
            $res = [];
            $res['errcode'] = ErrorCode::$LOGIN_FAILED;
            $res['errmsg'] = '登录失效';
            return json($res);
        }
        $this->adminInfo = $res;
    }
}
