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

namespace app\common\model;

use think\Model;

/**
 * 权限规则表
 */
class AuthRule extends Model
{

    //    protected $pk = 'id';

    public static $icon = ['│', '├', '└'];

    public static function getLists($where,$order){
        $lists = self::where($where)
            ->field('id,pid,name,title,status,condition,listorder')
            ->order($order)
            ->select();
        return $lists;
    }

    /* 整合多维数组 */
    public static function cateMerge($arr, $idName, $pidName, $pid = 0)
    {
        $result = array();
        foreach ($arr as $v) {
            if ($v[$pidName] == $pid) {
                $v['children'] = self::cateMerge($arr, $idName, $pidName, $v[$idName]);
                $result[] = $v;
            }
        }
        return $result;
    }

    /* 分类数型图 */
    public static function cateTree($arr, $idName, $pidName, $pid = 0, $level = 0, $html = '&nbsp;&nbsp;|--') {
        if (empty($arr)) {
            return array();
        }
        $result = array();
        $total  = count($arr);
        $number = 1;
        foreach ($arr as $val) {
            $tmp_str = str_repeat(self::$icon[0] . '&nbsp;', $level > 0 ? $level - 1 : 0);
            if ($total == $number) {
                $tmp_str .= self::$icon[2];
            } else {
                $tmp_str .= self::$icon[1];
            }
            if ($val[$pidName] == $pid) {
                $val['level'] = $level + 1;
                $val['html'] = '&nbsp;' . ($level == 0 ? '' : '&nbsp;' . $tmp_str . "&nbsp;");
                $result[] = $val;
                $result = array_merge($result, self::cateTree($arr, $idName, $pidName, $val[$idName], $val['level'], $html));
            }
            $number++;
        }
        return $result;
    }

    /* 查找它所有的上级分类 */
    public static function queryParentAll($arr, $idName, $pidName, $id)
    {
        $pids = array();
        while($id != 0){
            foreach($arr as $v){
                if($v[$idName] == $id){
                    $pids[] = $v[$idName];
                    $id = $v[$pidName];
                    break;
                }
            }
        }
        return $pids;
    }

}
