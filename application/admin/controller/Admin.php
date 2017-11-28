<?php

namespace app\admin\controller;

use app\admin\model\ErrorCode;
use \app\common\model\Admin as AdminModel;
use app\common\model\RoleAdmin;

/**
 * 管理员相关
 */
class Admin extends BaseCheckUser
{

    /**
     * 列表
     */
    public function index()
    {

        $where = [];
        $order = 'id DESC';
        $status = request()->get('status', '');
        if ($status !== ''){
            $where[] = ['status','=',intval($status)];
            $order = '';
        }
        $username = request()->get('username', '');
        if (!empty($username)){
            $where[] = ['username','like',$username . '%'];
            $order = '';
        }
        $limit = request()->get('limit/d', 20);
        //分页配置
        $paginate = [
            'type' => 'bootstrap',
            'var_page' => 'page',
            'list_rows' => ($limit <= 0 || $limit > 20) ? 20 : $limit,
        ];
        $lists = AdminModel::where($where)
            ->field('id,username,avatar,tel,email,status,last_login_ip,last_login_time,create_time')
            ->order($order)
            ->paginate($paginate);

        foreach ($lists as $k => $v) {
            $lists[$k]['avatar'] = AdminModel::getAvatarUrl($v['avatar']);
            $roles = RoleAdmin::where('admin_id',$v['id'])->field('role_id')->select();
            $temp_roles = [];
            if ($roles){
                $temp_roles = $roles->toArray();
                $temp_roles = array_column($temp_roles,'role_id');
            }
            $lists[$k]['roles'] = $temp_roles;
        }

        return json($lists);

    }

    /**
     * 获取用户信息
     * @return \think\response\Json
     */
    public function read()
    {
        $res = $this->adminInfo;
        $res['id'] = !empty($res['id']) ? intval($res['id']) : 0;
        $res['avatar'] = !empty($res['avatar']) ? AdminModel::getAvatarUrl($res['avatar']) : '';
        // $res['roles'] = ['admin'];
        return json($res);
    }

    /**
     * 添加管理员
     */
    public function save(){
        $data = $this->request->post();
        if (empty($data['username']) || empty($data['password'])){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }
        $username = $data['username'];
        // 菜单模型
        $info = AdminModel::where('username',$username)
            ->field('username')
            ->find();
        if ($info){
            $res = [];
            $res['errcode'] = ErrorCode::$ADMIN_REPEAT;
            $res['errmsg'] = '管理员已存在';
            return json($res);
        }

        $status = isset($data['status']) ? $data['status'] : 0;
        $AdminModel = new AdminModel();
        $AdminModel->username = $username;
        $AdminModel->password = AdminModel::getPass($data['password']);
        $AdminModel->status = $status;
        $AdminModel->create_time = time();
        $result = $AdminModel->save();

        if (!$result){
            $res = [];
            $res['errcode'] = ErrorCode::$NOT_NETWORK;
            $res['errmsg'] = '网络繁忙！';
            return json($res);
        }

        $roles = (isset($data['roles']) && is_array($data['roles'])) ? $data['roles'] : [];

        //$adminInfo = $this->adminInfo; // 登录用户信息
        $admin_id = $AdminModel->getLastInsID();
        if ($roles){
            $temp = [];
            foreach ($roles as $key => $value){
                $temp[$key]['role_id'] = $value;
                $temp[$key]['admin_id'] = $admin_id;
            }
            //添加用户的角色
            $RoleAdmin = new RoleAdmin();
            $RoleAdmin->saveAll($temp);
        }

        $res['id'] = $admin_id;
        $res['username'] = $AdminModel->username;
        $res['password'] = '';
        $res['status'] = $AdminModel->status;
        $res['roles'] = $roles;

        return json($res);
    }

    /**
     * 编辑管理员
     */
    public function edit(){
        $data = $this->request->post();
        if (empty($data['id'])){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }
        $id = $data['id'];
        // 菜单模型
        $AdminModel = AdminModel::where('id',$id)
            ->field('id')
            ->find();
        if (!$AdminModel){
            $res = [];
            $res['errcode'] = ErrorCode::$ADMIN_REPEAT;
            $res['errmsg'] = '管理员不存在';
            return json($res);
        }

        $status = isset($data['status']) ? $data['status'] : 0;
        $username = isset($data['username']) ? $data['username'] : 0;
        $password = isset($data['password']) ? AdminModel::getPass($data['password']) : '';
        $AdminModel->username = $username;
        if ($password){
            $AdminModel->password = $password;
        }
        $AdminModel->status = $status;
        $result = $AdminModel->save();

        $roles = (isset($data['roles']) && is_array($data['roles'])) ? $data['roles'] : [];
        if (!$result){
            // 没有做任何更改
            $temp_roles = RoleAdmin::where('admin_id',$id)->field('role_id')->select();
            if ($temp_roles){
                $temp_roles = $temp_roles->toArray();
                $temp_roles = array_column($temp_roles,'role_id');
            }
            // 没有差值，权限也没做更改
            if ($roles == $temp_roles){
                $res = [];
                $res['errcode'] = ErrorCode::$DATA_CHANGE;
                $res['errmsg'] = '数据没有任何更改';
                return json($res);
            }
        }


        if ($roles){
            // 先删除
            RoleAdmin::where('admin_id',$id)->delete();
            $temp = [];
            foreach ($roles as $key => $value){
                $temp[$key]['role_id'] = $value;
                $temp[$key]['admin_id'] = $id;
            }
            //添加用户的角色
            $RoleAdmin = new RoleAdmin();
            $RoleAdmin->saveAll($temp);
        }

        return 'SUCCESS';
    }

    /**
     * 删除管理员
     */
    public function delete(){
        $id = request()->post('id/d');
        if (empty($id)){
            $res = [];
            $res['errcode'] = ErrorCode::$HTTP_METHOD_NOT_ALLOWED;
            $res['errmsg'] = 'Method Not Allowed';
            return json($res);
        }
        if (!AdminModel::where('id',$id)->delete()){
            $res = [];
            $res['errcode'] = ErrorCode::$NOT_NETWORK;
            $res['errmsg'] = '网络繁忙！';
            return json($res);
        }
        // 删除权限
        RoleAdmin::where('admin_id',$id)->delete();

        return 'SUCCESS';

    }

}
