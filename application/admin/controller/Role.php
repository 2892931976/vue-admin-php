<?php

namespace app\admin\controller;

use app\admin\model\ErrorCode;
use app\common\model\AuthAccess;
use app\common\model\AuthRule;
use \app\common\model\Role as RoleModel;

/**
 * 角色相关
 */
class Role extends BaseCheckUser
{

    /**
     * 列表
     */
    public function index()
    {

        $where = [];
        $order = 'id ASC';
        $status = request()->get('status', '');
        if ($status !== ''){
            $where[] = ['status','=',intval($status)];
            $order = '';
        }
        $name = request()->get('name', '');
        if (!empty($name)){
            $where[] = ['name','like',$name . '%'];
            $order = '';
        }
        $lists = RoleModel::where($where)
            ->field('id,name,status,remark,create_time,listorder')
            ->order($order)
            ->select();

        return json($lists);

    }

    public function auth(){
        if (request()->isGet()){
            $id = request()->get('id/d','');
            $auth_access = AuthAccess::where('role_id',$id)
                ->field(['auth_rule_id'])
                ->select();
            $rule_list = AuthRule::getLists([],'id ASC');
            $checked_keys = [];
            foreach ($rule_list as $key=>$value){
                foreach ($auth_access as $k=>$v){
                    if (strtolower($value['id']) == strtolower($v['auth_rule_id'])){
                        $checked_keys[] = $v['auth_rule_id'];
                    }
                }
            }

            $merge_list = AuthRule::cateMerge($rule_list,'id','pid',0);
            $res['auth_list'] = $merge_list;
            $res['checked_keys'] = $checked_keys;
            return json($res);
        }

        $data = request()->post();
        $role_id = isset($data['role_id']) ? $data['role_id'] : '';
        if (!$role_id){
            $res = [];
            $res['errcode'] = ErrorCode::$NOT_NETWORK;
            $res['errmsg'] = '网络繁忙！';
            return json($res);
        }
        $auth_rules = isset($data['auth_rules']) ? $data['auth_rules'] : [];
        $rule_access = [];
        foreach ($auth_rules as $key=>$val){
            $rule_access[$key]['role_id'] = $role_id;
            $rule_access[$key]['auth_rule_id'] = $val;
            $rule_access[$key]['type'] = 'admin';
        }

        //先删除
        $AuthAccess = new AuthAccess();
        $AuthAccess->where(['role_id' => $role_id])->delete();
        if (!$rule_access || !$AuthAccess->saveAll($rule_access)){
            $res = [];
            $res['errcode'] = ErrorCode::$NOT_NETWORK;
            $res['errmsg'] = '网络繁忙！';
            return json($res);
        }

        return 'SUCCESS';

    }

    /**
     * 添加
     */
    public function save(){
        $data = request()->post();
        if (empty($data['name']) || empty($data['status'])){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }
        $name = $data['name'];
        // 菜单模型
        $info = RoleModel::where('name',$name)
            ->field('name')
            ->find();
        if ($info){
            $res = [];
            $res['errcode'] = ErrorCode::$DATA_REPEAT;
            $res['errmsg'] = '角色已存在';
            return json($res);
        }

        $now_time = time();
        $status = isset($data['status']) ? $data['status'] : 0;
        $RoleModel = new RoleModel();
        $RoleModel->name = $name;
        $RoleModel->status = $status;
        $RoleModel->remark = isset($data['remark']) ? strip_tags($data['remark']) : '';
        $RoleModel->create_time = $now_time;
        $RoleModel->update_time = $now_time;
        $result = $RoleModel->save();

        if (!$result){
            $res = [];
            $res['errcode'] = ErrorCode::$NOT_NETWORK;
            $res['errmsg'] = '网络繁忙！';
            return json($res);
        }

        $res['id'] = $RoleModel->getLastInsID();
        $res['name'] = $RoleModel->name;
        $res['status'] = $RoleModel->status;
        $res['remark'] = $RoleModel->remark;
        $res['create_time'] = $RoleModel->create_time;

        return json($res);
    }

    /**
     * 编辑
     */
    public function edit(){
        $data = request()->post();
        if (empty($data['id']) || empty($data['name'])){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }
        $id = $data['id'];
        $name = strip_tags($data['name']);
        // 模型
        $RoleModel = RoleModel::where('id',$id)
            ->field('id')
            ->find();
        if (!$RoleModel){
            $res = [];
            $res['errcode'] = ErrorCode::$DATA_NOT;
            $res['errmsg'] = '角色不存在';
            return json($res);
        }

        $info = RoleModel::where('name',$name)
            ->field('id')
            ->find();
        // 判断角色名称 是否重名，剔除自己
        if (!empty($info['id']) && $info['id'] != $id){
            $res = [];
            $res['errcode'] = ErrorCode::$DATA_REPEAT;
            $res['errmsg'] = '角色名称已存在';
            return json($res);
        }

        $status = isset($data['status']) ? $data['status'] : 0;
        $RoleModel->name = $name;
        $RoleModel->status = $status;
        $RoleModel->remark = isset($data['remark']) ? strip_tags($data['remark']) : '';
        $RoleModel->update_time = time();
        $RoleModel->listorder = isset($data['listorder']) ? intval($data['listorder']) : 999;
        $result = $RoleModel->save();

        if (!$result){
            $res = [];
            $res['errcode'] = ErrorCode::$DATA_CHANGE;
            $res['errmsg'] = '数据没有任何更改';
            return json($res);
        }


        return 'SUCCESS';
    }


    /**
     * 删除
     */
    public function delete(){
        $id = request()->post('id/d');
        if (empty($id)){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }
        if (!RoleModel::where('id',$id)->delete()){
            $res = [];
            $res['errcode'] = ErrorCode::$NOT_NETWORK;
            $res['errmsg'] = '网络繁忙！';
            return json($res);
        }

        return 'SUCCESS';

    }

}
