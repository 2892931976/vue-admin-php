<?php

namespace app\admin\controller;

use \app\common\model\Role as RoleModel;

/**
 * 权限相关
 */
class Role extends BaseCheckUser
{

    /**
     * 列表
     */
    public function index()
    {

        $where = [];
        $lists = RoleModel::where($where)
            ->field('id,name')
            ->select();

        return json($lists);

    }

}
