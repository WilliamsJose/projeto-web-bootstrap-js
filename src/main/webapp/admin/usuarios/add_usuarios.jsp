<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>

<mt:admin_tamplate title="Projeto" breadcrumb="Cadastrar Usuários">

	<jsp:attribute name="content">
	
	<section class="content">
			
		  <section class="content-header">
			<form class="text-center border border-light p-5" action="#!">
			
			    <p class="h4 mb-4">Novo Usuário</p>
				
				<div class="form-group text-left">
				    <label for="nome">Nome</label>
				    <input name="nome" type="text" id="nome" class="form-control mb-2" placeholder="williams" required>
			    </div>
			
				<div class="form-group text-left">
				    <label for="email">E-mail</label>
				    <input name="email" type="email" id="email" class="form-control mb-2" placeholder="williams@gmail.com.br" required>
			    </div>
			    
			    <div class="form-group text-left">
				    <label for="permissao">Permissões do usuário</label>
				    <select class="form-control mb-2" id="permissao" required>
				      <option value=""></option>
				      <option value="visitante">Visitante</option>
				      <option value="usuario">Usuário</option>
				      <option value="master">Master</option>
				      <option value="administrador">Administrador</option>
				    </select>
				</div>
			    
			    <!-- Enviar -->
			    <button id="btnSalvar" class="btn btn-info btn-sm" type="submit">Salvar</button>
			    
			    <!-- Listar -->
			    <a href="${pageContext.request.contextPath}/admin/usuarios/usuarios.jsp" class="btn btn-info btn-sm" type="submit">Usuários</a>
			
			</form>
	     </section>
     
     </section>
<script>
	// Agradecimentos ao https://gist.github.com/gordonbrander/2230317
	var generateID = function () {
	  return (Date.now().toString(36) + Math.random().toString(36).substr(2, 5)).toUpperCase();
	};

	const salvaNoLocalStorage = (novoUsuario) => {
		const editandoUsuarioID = sessionStorage.getItem("editandoUsuarioID");
		let usuarios = JSON.parse(localStorage.getItem("usuarios"));
		
		if(editandoUsuarioID == "null" && editandoUsuarioID != null) {
			let ID = generateID();
			if(usuarios === null) {
				usuarios = {}
				usuarios[ID] = novoUsuario;
			    localStorage.setItem("usuarios", JSON.stringify(usuarios));
			} else {
				usuarios[ID] = novoUsuario;
			    localStorage.setItem("usuarios", JSON.stringify(usuarios));
			}
		} else {
			usuarios[editandoUsuarioID] = novoUsuario;
			localStorage.setItem("usuarios", JSON.stringify(usuarios));
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

	const salvarNovoUsuario = (e) => {
		let nome = document.querySelector("#nome");
		let email = document.querySelector("#email");
		let permissao = document.querySelector("#permissao");
		let nomeVal = nome.value.trim();
		let emailVal = email.value.trim();
		let permissaoVal = permissao.value.trim();
		
		const emailRegex = /\S{1,}@\S{1,}.com(\.br)?$/gm
		
		if(algumCampoVazio(nomeVal, emailVal, permissaoVal)) {
			toastr.error("Você precisa preencher todos os campos!");
		} else if (emailVal.match(emailRegex) === null) {
			e.preventDefault();
			toastr.error("O email informado não é válido!");
		} else {
			e.preventDefault();
			novoUsuario = {
				"nome": nomeVal,
				"email": emailVal,
				"permissao": permissaoVal,
			};
			salvaNoLocalStorage(novoUsuario);
			limpaCampos(nome, email, permissao);
			const editando = sessionStorage.getItem("editandoUsuarioID");
			const cadOuNao = editando != 'null' && editando != null ? 'editado' : 'cadastrado'
			toastr.success("Usuário "+cadOuNao+" com sucesso!", "Sucesso");
			window.setTimeout(() => {
				window.location = "http://localhost:9090/agenda-acme/admin/usuarios/usuarios.jsp";
			}, 1500);
		}
	}
	
	btnSalvar = document.getElementById("btnSalvar").addEventListener("click", salvarNovoUsuario);
	
	const editando = () => {
		const editandoUsuarioID = sessionStorage.getItem("editandoUsuarioID");
		if (editandoUsuarioID != "null" && editandoUsuarioID != null) {			
			let usuarios = JSON.parse(localStorage.getItem("usuarios"));
			
			let editandoUsuario = usuarios[editandoUsuarioID];
			
			document.querySelector("#nome").value = editandoUsuario.nome;
			document.querySelector("#email").value = editandoUsuario.email;
			document.querySelector("#permissao").value = editandoUsuario.permissao;
		}
	}
	
	window.onload = editando();
	
	window.addEventListener("beforeunload", (e) => {
		delete e["returnValue"]
		sessionStorage.setItem("editandoUsuarioID", null);
	})
</script>

</jsp:attribute>


</mt:admin_tamplate>
