<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件
if (!function_exists('get_asset_static_path')) {
    /**
     * 获取静态资源相对路径
     * @param string $asset_url 文件的URL
     * @return string
     */
    function get_asset_static_path($asset_url = ''){
        if (empty($asset_url))
            return $asset_url;
        $filepath = config('static_url') . '/static/' . $asset_url;
        return $filepath;
    }
}

if (!function_exists('get_asset_image_url')) {
    /**
     * 获取文件相对路径
     * @param string $asset_url 文件的URL
     * @return string
     */
    function get_asset_image_url($asset_url = ''){
        if (empty($asset_url))
            return $asset_url;
        return get_asset_upload_path($asset_url);
    }
}

if (!function_exists('get_asset_upload_path')) {
    /**
     * 转化数据库保存的文件路径，为可以访问的url
     * @param string $file
     * @return string
     */
    function get_asset_upload_path($file = ''){

        if(strpos($file,"http") === 0){
            return $file;
        }else if(strpos($file,"/") === 0){
            return $file;
        }

        $filepath = config('custom.upload_domain') . '/uploads/' . $file;

        return $filepath;

    }
}