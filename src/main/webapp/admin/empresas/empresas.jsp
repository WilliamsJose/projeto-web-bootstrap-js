<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>

<mt:admin_tamplate title="Projeto" breadcrumb="Empresas">

	<jsp:attribute name="content">
	
	<section class="content">
			
		  <section class="content-header">
		  
		  	 <p class="h4 mb-4 text-center border border-light p-5">Empresas</p>
			
			<table class="table table-sm">
			  <thead>
			    <tr>
			      <th scope="col">Id</th>
			      <th scope="col">Nome</th>
			      <th scope="col">E-mail</th>
			      <th scope="col">CNPJ</th>
			      <th scope="col">Descrição</th>
			      <th scope="col">Ações</th>
			    </tr>
			  </thead>
			  <tbody id="renderCadastrados">
			    <tr>
			      <th scope="row">1</th>
			      <td>Mark</td>
			      <td>Otto</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <th scope="row">2</th>
			      <td>Jacob</td>
			      <td>Thornton</td>
			      <td>@fat</td>
			      <td>@mdo</td>
			    </tr>
			    <tr>
			      <th scope="row">3</th>
			      <td>@twitter</td>
			      <td>@twitter</td>
			      <td>@mdo</td>
			      <td>@mdo</td>
			    </tr>
			  </tbody>
			</table>
	     </section>
	     
	     <br/>
	      <!-- Listar -->
	      <div align="center">
			  <a href="${pageContext.request.contextPath}/admin/empresas/add_empresas.jsp" class="btn btn-info btn-sm" type="submit">Novo</a>
	      </div>
     
     </section>

<script>

	const render = (template, node) => {
		node.innerHTML = template;
	}
	
	const deleteThis = (id) => {
		let empresas = JSON.parse(localStorage.getItem("empresas"));
		delete empresas[id["id"]];
		localStorage.setItem("empresas", JSON.stringify(empresas));
		renderCadastros();
	}
	
	const editThis = (id) => {
		console.log(id["id"])
		sessionStorage.setItem("editandoEmpresaID", id["id"]);
		window.location = "add_empresas.jsp";
	}
	
	const renderCadastros = () => {
		const tBody = document.querySelector("#renderCadastrados");
	  	let empresas = JSON.parse(localStorage.getItem("empresas"));
	  
	  	let template = "";
		let	btnEdit = null;
		let btnExcluir = null;
		
		for (id in empresas) {
			btnEdit = '<button id='+id+' onclick="editThis('+id+')" type="button" class="btn btn-outline-warning"><span class="material-icons" style="font-size:18px;">edit</span></button>'
			btnExcluir = '<button id='+id+' onclick="deleteThis('+id+')" type="button" class="btn btn-outline-danger"><span class="material-icons" style="font-size:18px;">delete_forever</span></button>'
			template += ('<tr>'
			    + '<th scope="row">' +id+ '</th>'
			    + '<td>' +empresas[id]["nome"]+ '</td>'
			    + '<td>' +empresas[id]["email"]+ '</td>'
			    + '<td>' +empresas[id]["cnpj"]+ '</td>'
			    + '<td>' +empresas[id]["descricao"]+ '</td>'
			    + '<td style="width:50px;">' +btnEdit+ '</td>'
			    + '<td style="width:50px;">' +btnExcluir+ '</td>'
			    + '</tr>')
		}
	   
	  	render(template, tBody);
	}
	
	window.onload = renderCadastros();
	
	
</script>

</jsp:attribute>

</mt:admin_tamplate>


