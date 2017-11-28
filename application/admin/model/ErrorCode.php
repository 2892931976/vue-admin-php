<?php
// +----------------------------------------------------------------------
// | ThinkPHP 5 [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2016 .
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 黎明晓 <lmxdawn@gmail.com>
// +----------------------------------------------------------------------

namespace app\admin\model;

/**
 * 后台系统错误码
 * Class ErrorCode
 * @package app\common\model
 */
class ErrorCode
{

    // +----------------------------------------------------------------------
    // | 系统级错误码
    // +----------------------------------------------------------------------
    public static $NOT_NETWORK = 10001; // 网络繁忙

    // +----------------------------------------------------------------------
    // | 服务级错误码
    // +----------------------------------------------------------------------
    public static $HTTP_METHOD_NOT_ALLOWED = 20001; // 网络请求不予许
    public static $VALIDATION_FAILED = 20002; // 身份验证失败
    public static $USER_AUTH_FAIL = 20003; // 用户名或者密码错误
    public static $USER_NOT_PERMISSION = 20003; // 当前没有权限登录
    public static $AUTH_FAILED = 20004; // 权限验证失败
    public static $LOGIN_FAILED = 20005; // 登录失效
    public static $DATA_CHANGE = 20006; // 数据没有任何更改

    // 管理员相关
    public static $ADMIN_REPEAT = 30001; // 管理员重复

}
