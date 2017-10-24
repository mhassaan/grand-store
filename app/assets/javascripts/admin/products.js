$(document).on('turbolinks:load',function(){

	$('.options-list').select2();
	//var variant_ids = [];
	var option_ids = [];
	$('.options-list').on('select2:select', function (e) {
		console.log("Its a selected event");

    var data = e.params.data;
    console.log(data);
		$.ajax({
			url: '/products/'+data.id+'/get_product_options_tree',
			method: 'get',
			dataType:'json',
			data: {'id': data.id},
		}).done(function(response){
			console.log(response[0].id);
			product_options_tree ='<div class="row"> <div class="rana col-sm-4 col-md-6 col-xs-12"><div id="option_'+response[0].id+'"></div></div></div>';
			console.log(product_options_tree);
			//console.log("*******");
			$(product_options_tree).appendTo('#new_product');
			$('#option_'+response[0].id).jstree({
			//$('#variant-container').jstree({
				"core": {
					'check_callback': true,
					'data' : response,
				},
				"checkbox": {
					"keep_selected_style": false,
				},
				"plugins": ['checkbox']
			}).on("select_node.jstree", function (e, data) {

					if(data.node.parent === "#"){
						get_option_values(data,function(output){
							$.each(output,function(key,value){
								console.log("Now Logging Returned Response From Callback");
								console.log(key);
								option_ids.push({'option_id': value.parent,'option_value_id': value.id});
							});
						});

					}
					else {
						option_ids.push({'option_id': data.node.original.parent,'option_value_id':data.node.original.id});
						console.log("Option Ids are");
						console.log(JSON.stringify(option_ids));
					}
					console.log("Newly Added Logs");
					console.log(option_ids);
					$('#product_option_ids').val(JSON.stringify(option_ids));
				}).on("deselect_node.jstree",function(e,data){
					if(data.node.parent === "#"){
						get_option_values(data,function(output){
							$.each(output,function(key,value){
								remove_item = {'option_value_id': value.id,'option_id': value.parent};
								option_ids.splice($.inArray(remove_item,option_ids));
							});
						});
					}
					else {
						remove_item = {'option_value_id': data.node.original.id,'option_id': data.node.original.parent};
						option_ids.splice($.inArray(remove_item,option_ids));
					}
					$('#product_option_ids').val(JSON.stringify(option_ids));
					console.log("I am un slected!");
					console.log(option_ids);
				});

		}).fail(function(e){
			console.log("Ajax call failed.");
		});
	});

	$('.options-list').on('select2:unselect', function (e) {
		console.log("Its an unselect event");
		var data = e.params.data;
		$('#option_'+data.id).remove();
	});


	function get_option_values(data,handle_data){

		$.ajax({
			url:'/products/'+data.node.id+'/get_option_values' ,
			method: 'get',
			dataType: 'json',
			success: function(response){
				handle_data(response);
			},
		}).fail(function(e){
			console.log("Call Failed");
		});
	}






// 	a = $("[id*='variant_']");
// if (a[1] != null){
// 	var id = a[1].id.split('_')[1]
// 	var tree_root = a[1].id;
//
// 		$(tree_root).jstree().disable_checkbox(id);
// 	}
	//
	// $('#new_product').on('submit',function(e){
	// 	e.preven
	// });

	// $('#variant_13').on("click",function(data){
	// 	console.log("Click Worked");
	// });
	// $('#variant_13').on("get_checked.jstree",function(e,data){
	// 	console.log("Enable CheckBox");
	// 	console.log(data);
	// });
	// alert(1);
	// if ($("[id*='variant_13']").length > 0){
	// 	alert(1);
	// 	$('#variant_13').jstree(true).disable_node('13',true);
	// }

});
