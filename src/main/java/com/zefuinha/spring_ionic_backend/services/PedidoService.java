package com.zefuinha.spring_ionic_backend.services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zefuinha.spring_ionic_backend.domain.ItemPedido;
import com.zefuinha.spring_ionic_backend.domain.PagamentoComBoleto;
import com.zefuinha.spring_ionic_backend.domain.Pedido;
import com.zefuinha.spring_ionic_backend.domain.enums.EstadoPagamento;
import com.zefuinha.spring_ionic_backend.repositories.ItemPedidoRepository;
import com.zefuinha.spring_ionic_backend.repositories.PagamentoRepository;
import com.zefuinha.spring_ionic_backend.repositories.PedidoRepository;
import com.zefuinha.spring_ionic_backend.services.exceptions.ObjectNotFoundException;

@Service
public class PedidoService {

	@Autowired
	private PedidoRepository repository;

	@Autowired
	private PagamentoRepository pagamentoRepository;

	@Autowired
	private ItemPedidoRepository itemPedidoRepository;

	@Autowired
	private ProdutoService produtoService;
	
	@Autowired
	private ClienteService clienteService;

	@Autowired
	private BoletoService boletoService;

	public List<Pedido> findAll() {
		return repository.findAll();
	}

	public Pedido findById(Integer id) {

		// O Optional evita que ocorra um NullException caso não seja encontrada a
		// pedido do id informado
		Optional<Pedido> pedido = repository.findById(id);

		// Retorna a pedido, ou então uma exceção
		return pedido.orElseThrow(() -> new ObjectNotFoundException(
				"Pedido não encontrado. Id: " + id + ", Tipo: " + Pedido.class.getName()));

	}

	@Transactional
	public Pedido insert(Pedido pedido) {
		// Garante que seja mesmo um novo pedido na data atual com pagamento pendente
		pedido.setId(null);
		// Associa o cliente do ID informado ao pedido
		pedido.setCliente(clienteService.findById(pedido.getCliente().getId()));
		pedido.setCriadoEm(new Date());
		pedido.getPagamento().setEstado(EstadoPagamento.PENDENTE);
		pedido.getPagamento().setPedido(pedido);

		// É do tipo boleto?
		if (pedido.getPagamento() instanceof PagamentoComBoleto) {
			PagamentoComBoleto pagto = (PagamentoComBoleto) pedido.getPagamento();
			// Adiciona os dados do vencimento
			boletoService.preencherPagamento(pagto, pedido.getCriadoEm());
		}

		// Salva o pedido e o pagamento
		pedido = repository.save(pedido);
		pagamentoRepository.save(pedido.getPagamento());

		// Itens
		for (ItemPedido item : pedido.getItens()) {
			
			item.setDesconto(.0);
			// Setando o ID do produto do sistema
			item.setProduto(produtoService.findById(item.getId().getProduto().getId()));
			// Colocando o preço do item igual ao produto
			item.setPreco(item.getProduto().getPreco());
			// Setando o pedido
			item.setPedido(pedido);
		}
		// Salvando itens do pedido
		itemPedidoRepository.saveAll(pedido.getItens());

		// Teste no console
		System.out.println(pedido);

		return pedido;
	}

}
