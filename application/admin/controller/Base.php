<?php

namespace app\admin\controller;

use think\Controller;

/**
 * 基础控制器
 */

class Base extends Controller
{

    public function initialize()
    {
        parent::initialize();
        header('Access-Control-Allow-Origin:*');
        header('Access-Control-Allow-Methods:GET,POST,PUT,DELETE,PATCH,OPTIONS');
        header('Access-Control-Allow-Headers:Content-Type, X-ELEME-USERID, X-Eleme-RequestID, X-Shard,X-Shard, X-Eleme-RequestID,X-Adminid,X-Token');
    }
}
