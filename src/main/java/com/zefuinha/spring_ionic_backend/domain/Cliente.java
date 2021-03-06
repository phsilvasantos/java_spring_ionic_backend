package com.zefuinha.spring_ionic_backend.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zefuinha.spring_ionic_backend.domain.enums.Perfil;
import com.zefuinha.spring_ionic_backend.domain.enums.TipoCliente;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(exclude = { "nome", "enderecos", "telefones", "pedidos", "senha", "imageUrl" })
@Entity
public class Cliente implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String nome;
	private String imageUrl;

	@Column(unique = true) // Impede repetição de erros
	private String email;

	private String cpfOuCnpj;
	private Integer pessoa;

	// Campo de senha não deve aparecer no JSON
	@JsonIgnore
	private String senha;

	// Reflete em cascata a todas as operações (Se apagar o cliente, o endereço é
	// apagado)
	@OneToMany(mappedBy = "cliente", cascade = CascadeType.ALL)
	private List<Endereco> enderecos = new ArrayList<>();

	/**
	 * Quando não tem uma classe para o campo estrangeiro, usa-se
	 * \@ElementCollection e \@CollectionTable
	 */
	@ElementCollection
	@CollectionTable(name = "telefones")
	private Set<String> telefones = new HashSet<>();

	// FetchType.EAGER garante que os perfis serão sempre buscados junto
	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name = "perfis")
	private Set<Integer> perfis = new HashSet<>();

	@JsonIgnore
	@OneToMany(mappedBy = "cliente")
	private List<Pedido> pedidos = new ArrayList<>();

	/**
	 * Todo cliente terá pelo menos o perfil de cliente
	 */
	public Cliente() {
		addPerfil(Perfil.CLIENTE);
	}

	/**
	 * Necessário para não incluir listas
	 * 
	 * @param id
	 * @param nome
	 * @param email
	 * @param cpfOuCnpj
	 * @param pessoa
	 */
	public Cliente(Integer id, String nome, String email, String cpfOuCnpj, TipoCliente pessoa, String senha) {
		super();
		this.id = id;
		this.nome = nome;
		this.email = email;
		this.cpfOuCnpj = cpfOuCnpj;
		this.pessoa = (pessoa == null) ? null : pessoa.getCod();
		this.senha = senha;

		// Todo cliente terá pelo menos o perfil de cliente
		addPerfil(Perfil.CLIENTE);
	}

	/**
	 * Faz a conversão de inteiro para Enum
	 * 
	 * @return
	 */
	public TipoCliente getPessoa() {
		return TipoCliente.toEnum(pessoa);
	}

	/**
	 * Faz a conversão de Enum para inteiro
	 * 
	 * @param pessoa
	 */
	public void setPessoa(TipoCliente pessoa) {
		this.pessoa = pessoa.getCod();
	}

	/**
	 * Pega os perfis do cliente no formato de ENUM
	 * 
	 * @return
	 */
	public Set<Perfil> getPerfis() {
		return perfis.stream().map(x -> Perfil.toEnum(x)).collect(Collectors.toSet());
	}

	/**
	 * Seta um perfil novo para este cliente
	 * 
	 * @param perfil
	 */
	public void addPerfil(Perfil perfil) {
		perfis.add(perfil.getCod());
	}
}
