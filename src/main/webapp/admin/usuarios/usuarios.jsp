<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>

<mt:admin_tamplate title="Projeto" breadcrumb="Usuários">

	<jsp:attribute name="content">
	
	<section class="content">
			
		  <section class="content-header">
			<p> Listagem de Usuários</p>    
			<table class="table table-sm">
			  <thead>
			    <tr>
			      <th scope="col">Id</th>
			      <th scope="col">Nome</th>
			      <th scope="col">E-mail</th>
			      <th scope="col">Permissão</th>
			      <th scope="col">Ações</th>
			    </tr>
			  </thead>
			  <tbody id="renderUsers">
			    <tr>
			      <th scope="row">1</th>
			      <td>Mark</td>
			      <td>e-mail</td>
			      <td>ações</td>
			    </tr>
		   	</tbody>
		   </table>
		   
		   <div align="center">
			  <a href="${pageContext.request.contextPath}/admin/usuarios/add_usuarios.jsp" class="btn btn-info btn-sm" type="submit">Novo</a>
 	       </div>
	     </section>
     
     </section>

<script>
	const render = (template, node) => {
		node.innerHTML = template;
	}
	
	const deleteThis = (id) => {
		let usuarios = JSON.parse(localStorage.getItem("usuarios"));
		delete usuarios[id];
		localStorage.setItem("usuarios", JSON.stringify(usuarios));
		renderCadastros();
		toastr.success("Usuário removido com sucesso!", "Sucesso");
	}
	
	const editThis = (id) => {
		sessionStorage.setItem("editandoUsuarioID", id);
		window.location = "add_usuarios.jsp";
	}
	
	const renderCadastros = () => {
		const tBody = document.querySelector("#renderUsers");
	  	let usuarios = JSON.parse(localStorage.getItem("usuarios"));
	  
	  	let template = "";
		let	btnEditar = null;
		let btnExcluir = null;
		
		for (id in usuarios) {
			console.log("id no for:", id)
			btnEditar = '<button id='+id+' onclick="editThis(this.id)" type="button" class="btn btn-outline-warning"><span class="material-icons" style="font-size:18px;">edit</span></button>'
			btnExcluir = '<button id='+id+' onclick="deleteThis(this.id)" type="button" class="btn btn-outline-danger ml-2"><span class="material-icons" style="font-size:18px;">delete_forever</span></button>'
			template += ('<tr>'
			    + '<th scope="row">' +id+ '</th>'
			    + '<td>' +usuarios[id]["nome"]+ '</td>'
			    + '<td>' +usuarios[id]["email"]+ '</td>'
			    + '<td>' +usuarios[id]["permissao"]+ '</td>'
			    + '<td>'+btnEditar + btnExcluir+'</td>'
			    + '</tr>')
		}
	   
	  	render(template, tBody);
	}
	
	window.onload = renderCadastros();
	
	
</script>

</jsp:attribute>

</mt:admin_tamplate>