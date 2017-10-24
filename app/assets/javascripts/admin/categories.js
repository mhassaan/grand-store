//$(function(){
$(document).on('turbolinks:load',function(){

	$('.category-variants-list').select2();

	function build_tree(root_node){
		$('#tree-container').jstree({
		  "core" : {
		    "check_callback" : true,
				'data':root_node,
		  },
			"checkbox" : {
				"keep_selected_style": false,
			},
		  "plugins" : ["dnd","contextmenu","checkbox"]
		});
	}

	function add_node_to_tree(data){
		var parent = data.node.parent;
		var node_text = data.node.text;

		// console.log("New Node Id is:"+node_id);
		console.log("Category ID:"+category_id);
		$.ajax({
			url: '/add_node_to_tree',
			method: 'post',
			dataType: 'json',
			data: {parent_id: parent, node_text: node_text},
		})
		.done(function(response){
			//set_new_node_id(response);
			data.instance.set_id(data.node,response.id);
			console.log(data.instance);
			console.log("Add node to tree data:"+data);
			console.log("New added node has id:"+JSON.stringify(response.id));
			console.log("New added node has text:"+JSON.stringify(response.title));
			console.log("New node has search node id:"+ JSON.stringify(response.node_search_id));
			return true;
		})
		.fail(function(){
			console.log("Soething went wrong");
			return false;
		});
	}
	// This regex works for now but need to be changed in future, because it allows the id passed only in range between [1-9999].
	//var url_regex = /\/categories\/\d{1}|\d{2}|\d{3}|\d{4}\/edit/;

	if (window.location.pathname.includes('categories') && window.location.pathname.includes('edit')){
		var category_id = window.location.href.split('/')[4]
		console.log("Category ID:"+category_id);
		$.ajax({
			url: '/categories/'+category_id+'/get_root_node',
			method: 'get',
			dataType: 'json',
			//data: {id: category_id}
		})
		.done(function(response){
			//var id = $("#tree-container").jstree('create_node','#',{'id': JSON.stringify(response.id),'text': JSON.stringify(response.title)});
			// var root_node = [];
			// root_node.push({'id': JSON.stringify(response.id),'text': JSON.stringify(response.title)});
			//window.location.href = '/test';
			build_tree (response);
			return true;
		})
		.fail(function(){
			console.log("Something went wrong");
			return false;
		});
	}


$('#tree-container').on("create_node.jstree",function(e,data){
	console.log("Called on Create");
	// console.log(data.instance);
	// console.log(data.instance.parent);
	// console.log(data.instance.get_parent());
	add_node_to_tree(data);
	// data.node gives me the info of current node i want to create, like this data.node.id and data.node.text
	// data.parent returns me the id of the parent of the current node
});

$('#tree-container').on("set_text.jstree",function(e,data){
	console.log("Set text called");
	console.log(data);
	console.log(data.obj.id);
	console.log(data.obj.text);
	node_id = data.obj.id;
	node_text = data.obj.text;
	$.ajax({
		url: '/update_node_text',
		method: 'post',
		dataType: 'json',
		data: {id: node_id,text: node_text},
	}).done(function(response){
		console.log("New node updated text is:"+ response.title);
		return true;
	}).fail(function(response){
		console.log("Something went wrong while updating text of new node");
	});
	// console.log(data.node.id);
	// console.log(data.node.text);
	//console.log("Set Text event called");
});

$('#tree-container').on("select_node.jstree",function(e,data){
	console.log("###############");
	console.log(data);
});

});
