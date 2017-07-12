
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../css/easyui.css">
    <link rel="stylesheet" href="../css/icon.css">
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/easyui.js" type="text/javascript"></script>
    <script>
        function init(){
           /* $("#first").datagrid({
                title:'用户',
                columns:[[
                    {field:"account",title:"账号",width:100}
                ]],
                toolbar:[
                    <shiro:hasPermission name="user:create">
                    {text:"添加",iconCls:'icon-add'},
                    </shiro:hasPermission>
                    <shiro:hasPermission name="user:update">
                    {text:"修改",iconCls:'icon-add'},
                    </shiro:hasPermission>
                    <shiro:hasPermission name="user:delete">
                    {text:"删除",iconCls:'icon-remove'},
                    </shiro:hasPermission>
                ]
            })*/

        $("#menu_tree").tree({
            onClick:function(node){
                alert(node.url)
                var had=$("#work").tabs("exists",node.text);
                if(!had){
                    $("#work").tabs("add",{
                        title:node.text,
                        closable:true,
                        href:node.url
                    })
                }else {
                    $("#work").tabs("select",node.text);
                }
            }

        });


        }
        $(init)
    </script>
</head>
<body>
<div class="easyui-layout" style="width:100%;height:600px">
    <div data-options="region:'north'" style="width:100%;height:100px"></div>
    <div  data-options="region:'west'" style="width:15%;">
        <ul id="menu_tree" class="easyui-tree" data-options="url:'../selectQxByUser.do'"></ul>
    </div>
    <div id="work" class="easyui-tabs" data-options="region:'center'" style="width:70%;">

    </div>
    <div data-options="region:'east'" style="width:15%" >
        <div id="cc" class="easyui-calendar" style="width:190px"> </div>
    </div>

    <div data-options="region:'south'" style="width:100%;height:50px"></div>
</div>

</body>
</html>
