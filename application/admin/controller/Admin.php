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
     * 列表
     */
    public function index(){

        $where = [];
        $limit = request()->get('limit/d',20);
        //分页配置
        $paginate = [
            'type' => 'bootstrap',
            'var_page' => 'offset',
            'list_rows' => ($limit <= 0 || $limit > 20) ? 20 : $limit,
        ];
        $lists = AdminModel::where($where)
            ->field('id,username,status,avatar,last_login_ip,last_login_time,create_time')
            ->paginate($paginate);

        dump($lists);


    }

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
        $res['avatar'] = !empty($res['avatar']) ? AdminModel::getAvatarUrl($res['avatar']) : '';
        // $res['roles'] = ['admin'];
        return json($res);
    }
}
