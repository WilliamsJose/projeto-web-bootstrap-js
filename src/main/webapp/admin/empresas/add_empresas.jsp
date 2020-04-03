<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>

<mt:admin_tamplate title="Projeto" breadcrumb="Cadastrar Empresas">

	<jsp:attribute name="content">
	
	<section class="content">
			
		  <section class="content-header">
			<form class="text-center border border-light p-5" action="#!">
			
			    <p class="h4 mb-4">Nova Empresa</p>
				
				<div class="form-group">
				    <!-- Name -->
				    <input name="nome" type="text" id="nome" class="form-control mb-4" placeholder="Name" required>
			    </div>
			
				<div class="form-group">
				    <!-- Email -->
				    <input name="email" type="email" id="email" class="form-control mb-4" placeholder="E-mail" required>
			    </div>
			    
			    <div class="form-group">
				     <!-- CNPJ -->
				    <input name="cnpj" type="text" id="cnpj" class="form-control mb-4" placeholder="CNPJ" required>
			    </div>
			
			    <!-- Message -->
			    <div class="form-group">
			        <textarea name="descricao" class="form-control rounded-0" id="descricao" rows="3" placeholder="Descrição" required></textarea>
			    </div>
			
			
			    <!-- Enviar -->
			    <button id="btnSalvar" class="btn btn-info btn-sm" type="submit">Salvar</button>
			    
			    <!-- Listar -->
			    <a href="${pageContext.request.contextPath}/admin/empresas/empresas.jsp" class="btn btn-info btn-sm" type="submit">Empresas</a>
			
			</form>
	     </section>
     
     </section>
<script>
	// Agradecimentos ao https://gist.github.com/gordonbrander/2230317
	var generateID = function () {
	  return (Date.now().toString(36) + Math.random().toString(36).substr(2, 5)).toUpperCase();
	};

	const salvaNoLocalStorage = (novaEmpresa) => {
		const editandoEmpresaID = sessionStorage.getItem("editandoEmpresaID");
		let empresas = JSON.parse(localStorage.getItem("empresas"));
		
		if(editandoEmpresaID == "null") {
			console.log("entrou no empresasid null")
			let ID = generateID();
			if(empresas === null) {
				console.log("entrou no else empresas null")
			    empresas = {}
			    empresas[ID] = novaEmpresa;
			    localStorage.setItem("empresas", JSON.stringify(empresas));
			} else {
				console.log("entrou no else empresas not null")
			    empresas[ID] = novaEmpresa;
			    localStorage.setItem("empresas", JSON.stringify(empresas));
			}
		} else {
			console.log("entrou no else empresasid null")
			empresas[editandoEmpresaID] = novaEmpresa;
			localStorage.setItem("empresas", JSON.stringify(empresas));
		}
	}
	
	function algumCampoVazio() {
	  for (let i = 0; i < arguments.length; i++) {
	    if (arguments[i] === "") {
	    	return true
	    } 
	  }
		return false;
	}
	
	function limpaCampos() {
	  for (let i = 0; i < arguments.length; i++) {
	    arguments[i].value = null;
	  }
	}

	const salvarNovaEmpresa = (e) => {
		let nome = document.querySelector("#nome");
		let email = document.querySelector("#email");
		let cnpj = document.querySelector("#cnpj");
		let descricao = document.querySelector("#descricao");
		let nomeVal = nome.value.trim();
		let emailVal = email.value.trim();
		let cnpjVal = cnpj.value.trim();
		let descricaoVal = descricao.value.trim();
		
		const emailRegex = /\S{1,}@\S{1,}.com(\.br)?$/gm
		
		if(algumCampoVazio(nomeVal, emailVal, cnpjVal, descricaoVal)) {
			toastr.error("Você precisa preencher todos os campos!");
		} else if (emailVal.match(emailRegex) === null) {
			e.preventDefault();
			toastr.error("O email informado não é válido!");
		} else {
			e.preventDefault();
			novaEmpresa = {
				"nome": nomeVal,
				"email": emailVal,
				"cnpj": cnpjVal,
				"descricao": descricaoVal
			};
			salvaNoLocalStorage(novaEmpresa);
			limpaCampos(nome, email, cnpj, descricao);
			toastr.success("Empresa cadastrada com sucesso!", "Sucesso");
			window.setTimeout(() => {
				window.location = "http://localhost:9090/agenda-acme/admin/empresas/empresas.jsp";
			}, 1500);
		}
	}
	btnSalvar = document.getElementById("btnSalvar").addEventListener("click", salvarNovaEmpresa);
	
	
	const editando = () => {
		const editandoEmpresaID = sessionStorage.getItem("editandoEmpresaID");
		if (editandoEmpresaID != "null") {
			console.log("entrou no editando")
			
			let empresas = JSON.parse(localStorage.getItem("empresas"));
			
			let editandoEmpresa = empresas[editandoEmpresaID]
			
			document.querySelector("#nome").value = editandoEmpresa.nome;
			document.querySelector("#email").value = editandoEmpresa.email;
			document.querySelector("#cnpj").value = editandoEmpresa.cnpj;
			document.querySelector("#descricao").value = editandoEmpresa.descricao;
		}
	}
	window.onload = editando();
	window.addEventListener("beforeunload", (e) => {
		delete e["returnValue"]
		sessionStorage.setItem("editandoEmpresaID", null);
	})
</script>

</jsp:attribute>


</mt:admin_tamplate>
