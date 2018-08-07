<#import "spring.ftl" as s>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
    <#include 'include/baselink.ftl'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<@s.url'/assets/css/jquery.pagination.css'/>">
</head>
<body>
<div id="main">
    <section>
        <section id="content" class="table-layout animated fadeIn">
            <div class="tray tray-center">
                <div class="panel-body">
                    <div class="tab-content pn br-n">
                        员工列表
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-inline">
                        <div class="form-group">
                            <div class="input-group input-group-sm">
                                <div class="input-group-addon btn btn-default">姓名：</div>
                                <input type="text" class="form-control input-sm w200" placeholder="请输入姓名"
                                       v-model="searchInfo.name">
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-success" @click="findList">
                            <span class="fa fa-search"> 查询</span>
                        </button>
                        <button class="btn btn-danger btn-sm " data-target="#insert_model" data-toggle="modal">
                            <span class="fa fa-plus"> 添加</span>
                        </button>
                        <button class="btn btn-danger btn-sm " @click="delIds(userIds)">
                            <span class="fa fa-trash"> 删除所选</span>
                        </button>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-hover" id="users_table">
                                <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" id="check_all" @click="checkAll"
                                        :checked="userIds.length === users.length && userIds.length" />
                                    </th>
                                    <th>#</th>
                                    <th>姓名</th>
                                    <th>地址</th>
                                    <th>生日</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="user in users">
                                    <td>
                                        <input type='checkbox' class='check_item' @click="checkOne(user.id)"
                                        :checked="userIds.indexOf(user.id)>=0"/>
                                    </td>
                                    <td>{{user.id}}</td>
                                    <td>{{user.name}}</td>
                                    <td>{{user.address}}</td>
                                    <td>{{user.birthday}}</td>
                                    <td>
                                        <button class="btn btn-primary btn-sm " @click="update(user)"
                                                data-target="#update_model" data-toggle="modal">
                                            <span class="fa fa-pencil"> 编辑</span>
                                        </button>
                                        <button class="btn btn-danger btn-sm " @click="del(user.id)">
                                            <span class="fa fa-trash"> 删除</span>
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <div class="table-responsive" style="margin-top: 10px ">
                                <div id="pageMenu"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
    <#--添加-->
    <div class="modal fade" id="insert_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加用户</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="exampleInputEmail1">姓名</label>
                        <input type="text" class="form-control" v-model="insertUser.name">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">地址</label>
                        <input type="text" class="form-control" v-model="insertUser.address">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">生日</label>
                        <input type="text" id="birthdayTimeOfInsert" class="form-control datainp date_time" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" @click="insert"
                            data-dismiss="modal"> 保存
                    </button>
                </div>
            </div>
        </div>
    </div>
    <#--编辑-->
    <div class="modal fade" id="update_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">修改用户</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="exampleInputEmail1">姓名</label>
                        <input type="text" class="form-control" v-model="updateUser.name">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">地址</label>
                        <input type="text" class="form-control" v-model="updateUser.address">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">生日</label>
                        <input type="text" id="birthdayTimeOfUpdate" class="form-control datainp date_time"
                               v-model="updateUser.birthday" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" @click="updated"
                            data-dismiss="modal"> 保存
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<#include 'include/footer_js.ftl'/>
<script src="/assets/js/jquery.pagination-1.2.7.js"></script>
<script src="<@s.url'/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js'/>"></script>
<script src="<@s.url'/assets/plugins/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js'/>"></script>
<script>
    var app = new Vue({
        el: '#main',
        data: {
            users: [],
            searchInfo:{
                name:'',
                address:'',
                birthday:'',
                page: 1 ,
                pageSize : 5
            },
            insertUser:{},
            updateUser:{},
            userIds:[],
            isChecked: false
        },
        created: function () {
            this.searchInfo.page = 1;
            this.findList();
        },
        mounted: function () {
            $("#birthdayTimeOfInsert").datepicker({
                language: "zh_CN",
                autoclose: true,
                format: "yyyy-mm-dd"
            });
            $("#birthdayTimeOfInsert").datepicker();
            $("#birthdayTimeOfUpdate").datepicker({
                language: "zh_CN",
                autoclose: true,
                format: "yyyy-mm-dd"
            });
            $("#birthdayTimeOfUpdate").datepicker();
        },
        computed: {},
        watch: {
            "searchInfo.name": function () {
                this.findList();
            },
            "searchInfo.page": function () {
                this.query();
            }
        },
        methods: {
            findList: function () {
                this.searchInfo.page = 1;
                $('#pageMenu').page('destroy');
                this.query();
            },
            query: function () {
                var url = "/api/user/list";
                this.$http.post(url, this.searchInfo).then(function (response) {
                    this.users = response.body.data.list;
                    console.log(response);
                    var temp = this;
                    $("#pageMenu").page({
                        total: response.body.data.total,
                        pageSize: response.body.data.pageSize,
                        firstBtnText: '首页',
                        lastBtnText: '尾页',
                        prevBtnText: '上一页',
                        nextBtnText: '下一页',
                        showInfo: true,
                        showJump: true,
                        jumpBtnText: '跳转',
                        infoFormat: '{start} ~ {end}条，共{total}条'
                    }, response.body.data.page).on("pageClicked", function (event, pageIndex) {
                        temp.searchInfo.page = pageIndex + 1;
                    }).on('jumpClicked', function (event, pageIndex) {
                        temp.searchInfo.page = pageIndex + 1;
                    });
                }, function (error) {
                    swal(error.body.msg);
                });
            },
            insert: function () {
                this.insertUser.birthday = $("#birthdayTimeOfInsert").val();
                var url = "api/user/insert";
                this.$http.post(url,this.insertUser).then(function (response) {
                    sweetAlert("操作成功！");
                    this.findList();
                },function (error) {
                    swal(error.body.msg);
                });
            },
            update: function (user) {
                this.updateUser = user;
            },
            updated: function () {
                this.updateUser.birthday = $("#birthdayTimeOfUpdate").val();
                var url = "api/user/update";
                this.$http.post(url,this.updateUser).then(function (response) {
                    sweetAlert("操作成功！");
                    this.findList();
                },function (error) {
                    swal(error.body.msg);
                });
            },
            del: function (id) {
                var url = "api/user/delete?id=" + id;
                this.$http.get(url).then(function (response) {
                    sweetAlert("操作成功！");
                    this.findList();
                },function (error) {
                    swal(error.body.msg);
                });
            },
            checkOne: function (id) {
                let index = this.userIds.indexOf(id);
                if(index>=0){
                    this.userIds.splice(index,1);
                }else{
                    this.userIds.push(id);
                }
            },
            checkAll: function (e) {
                this.isChecked = e.target.checked;
                if(this.isChecked){
                    this.userIds = [];
                    this.users.forEach(a => {this.userIds.push(a.id)});
                }else{
                    this.userIds = [];
                }
            },
            delIds: function (ids) {
                var url = "api/user/deleteIds?ids=" + ids;
                this.$http.get(url).then(function (response) {
                    sweetAlert("操作成功！");
                    this.findList();
                },function (error) {
                    swal(error.body.msg);
                });
            }
        }
    });
</script>
</body>
</html>