use ecommerce;

INSERT INTO Cliente VALUES();
INSERT INTO Cliente VALUES();
INSERT INTO Cliente VALUES();
INSERT INTO Cliente VALUES();
INSERT INTO ClientePessoaFisica(primeiroNome, nomeMeio, sobrenome, cpf, Cliente_idCliente, dataNascimento) VALUES ('JOAO', NULL, 'SILVA', '1-91', 1, '2000-02-10');
INSERT INTO ClientePessoaFisica(primeiroNome, nomeMeio, sobrenome, cpf, Cliente_idCliente, dataNascimento) VALUES ('MARIA', 'TAVARES', 'FERREIRA', '2-72', 2, '1950-01-17');
INSERT INTO Endereco(logradouro, numero, complemento, cep, bairro, cidade, estado, Cliente_idCliente) VALUES ('AVENIDA PAULISTA', 1001, 'AP12', '02515-222', 'BELA VISTA', 'SÃO PAULO', 'SP', 1);
INSERT INTO Endereco(logradouro, numero, complemento, cep, bairro, cidade, estado, Cliente_idCliente) VALUES ('AVENIDA JABAQUARA', 545, NULL, '12345-678', 'VILA CLEMENTINO', 'SÃO PAULO', 'SP', 3);
INSERT INTO CartaoDeCredito(numero, validade, nome, cpf, Cliente_idCliente, Endereco_idEndereco) VALUES ('1234-1234-1234-1234', '2028-09-30', 'JOAO SILVA', '1-91', 1, 1);
INSERT INTO Pedido(status, descricao, valorfrete, Cliente_idCliente) VALUES (default, 'Primeira compra do Joao Silva', 12.55, 1);
INSERT INTO Pedido(status, descricao, valorfrete, Cliente_idCliente) VALUES (default, 'Segunda compra do Joao Silva', 13.11, 1);
INSERT INTO Produto(categoria, descricao, valor) VALUES ('Eletrônico', 'Apple iPhone 13', 3000.00);
INSERT INTO Produto(categoria, descricao, valor) VALUES ('Eletrônico', 'Samsung Galaxy S21', 1500.00);
INSERT INTO Produto(categoria, descricao, valor) VALUES ('Eletrônico', 'Nokia Indestrutivel', 100.00);
INSERT INTO Produto(categoria, descricao, valor) VALUES ('Vestuário', 'Cuecão', 20.00);
INSERT INTO Produto(categoria, descricao, valor) VALUES ('Brinquedo', 'Super trunfo', 45.00);
INSERT INTO Produto(categoria, descricao, valor) VALUES ('Eletrônico', 'XBOX X SERIES', 4500.00);
INSERT INTO ItemPedido(quantidade, Pedido_idPedido, Produto_idProduto) VALUES (1, 1, 1);
INSERT INTO ItemPedido(quantidade, Pedido_idPedido, Produto_idProduto) VALUES (3, 1, 4);
INSERT INTO ItemPedido(quantidade, Pedido_idPedido, Produto_idProduto) VALUES (1, 1, 6);
INSERT INTO ItemPedido(quantidade, Pedido_idPedido, Produto_idProduto) VALUES (1, 2, 5);
INSERT INTO PessoaJuridica(razaoSocial, cnpj) VALUES ('ORGANIZACOES TABAJARA', '13.123.123/0001-12');
INSERT INTO PessoaJuridica(razaoSocial, cnpj) VALUES ('MICROSOSFT CORPORATION', '22.222.222/0001-22');
INSERT INTO Fornecedor(PessoaJuridica_idEmpresa) VALUES (2);
INSERT INTO ProdutoFornecedor(Fornecedor_idFornecedor, Produto_idProduto) VALUES (1, 6);
INSERT INTO Estoque(local) VALUES ('SÃO PAULO/SP');
INSERT INTO Estoque(local) VALUES ('RECIFE/PE');
INSERT INTO ProdutoEstoque(Estoque_idEstoque, Produto_idProduto, quantidade) VALUES (1, 1, 1);
INSERT INTO ProdutoEstoque(Estoque_idEstoque, Produto_idProduto, quantidade) VALUES (2, 2, 0);
INSERT INTO ProdutoEstoque(Estoque_idEstoque, Produto_idProduto, quantidade) VALUES (1, 3, 2);
INSERT INTO ProdutoEstoque(Estoque_idEstoque, Produto_idProduto, quantidade) VALUES (2, 4, 3);
INSERT INTO ProdutoEstoque(Estoque_idEstoque, Produto_idProduto, quantidade) VALUES (1, 5, 4);
INSERT INTO ProdutoEstoque(Estoque_idEstoque, Produto_idProduto, quantidade) VALUES (1, 6, 100);
INSERT INTO EmpresaLogistica(PessoaJuridica_idEmpresa) VALUES (1);
INSERT INTO Entrega(Pedido_idPedido, EmpresaLogistica_idEmpresaLogistica, status, codigoRastreio) VALUES (1, 1, 'Em Transporte', 'ONONONONO');
INSERT INTO Entrega(Pedido_idPedido, EmpresaLogistica_idEmpresaLogistica, status, codigoRastreio) VALUES (2, 1, 'Coletado', 'SASASASASAS');
INSERT INTO HistoricoEntrega(status, datahora, responsavel, Entrega_idEntrega) VALUES ('Coletado', '2022-08-01 10:15:21', 'MARILSON', 1);
INSERT INTO HistoricoEntrega(status, datahora, responsavel, Entrega_idEntrega) VALUES ('Em Transporte', '2022-08-04 14:12:01', 'JOELSON', 1);
INSERT INTO HistoricoEntrega(status, datahora, responsavel, Entrega_idEntrega) VALUES ('Coletado', '2022-09-07 09:08:55', 'MARINELSON', 2);
INSERT INTO FormaPagamento(tipo) VALUES ('Boleto');
INSERT INTO FormaPagamento(tipo) VALUES ('Cartão de Crédito');
INSERT INTO FormaPagamento(tipo) VALUES ('Cartão de Débito');
INSERT INTO FormaPagamento(tipo) VALUES ('Pix');
INSERT INTO Pagamento(Pedido_idPedido, FormaPagamento_idFormaPagamento) VALUES (1, 4);
INSERT INTO Pagamento(Pedido_idPedido, FormaPagamento_idFormaPagamento) VALUES (2, 2);
INSERT INTO PagamentoCartaoDeCredito(Pagamento_idPagamento, CartaoDeCredito_idCartaoDeCredito) VALUES (2, 1);
INSERT INTO ClientePessoaJuridica(PessoaJuridica_idEmpresa, Cliente_idCliente) VALUES (1, 3);
INSERT INTO ClientePessoaJuridica(PessoaJuridica_idEmpresa, Cliente_idCliente) VALUES (2, 4);

SELECT * FROM Cliente;
SELECT * FROM ClientePessoaFisica;
SELECT * FROM Endereco;
SELECT * FROM CartaoDeCredito;
SELECT * FROM Pedido;
SELECT * FROM Produto;
SELECT * FROM ItemPedido;
SELECT * FROM PessoaJuridica;
SELECT * FROM Fornecedor;
SELECT * FROM ProdutoFornecedor;
SELECT * FROM Estoque;
SELECT * FROM ProdutoEstoque;
SELECT * FROM EmpresaLogistica;
SELECT * FROM Entrega;
SELECT * FROM HistoricoEntrega;
SELECT * FROM VendedorTerceiro;
SELECT * FROM ProdutoTerceiro;
SELECT * FROM FormaPagamento;
SELECT * FROM Pagamento;
SELECT * FROM PagamentoCartaoDeCredito;
SELECT * FROM ClientePessoaJuridica;

SELECT COUNT(1) FROM Cliente;
SELECT * FROM cliente c, pedido p WHERE c.idCliente = p.Cliente_idCliente;
SELECT cp.primeiroNome, cp.sobrenome, p.idPedido, p.status FROM cliente c, pedido p, clientepessoafisica cp WHERE c.idCliente = p.Cliente_idCliente and cp.Cliente_idCliente = c.idCliente;
SELECT c.Cliente_idCliente, c.primeiroNome, count(1) qtd FROM clientepessoafisica c INNER JOIN pedido p ON c.Cliente_idCliente = p.Cliente_idCliente GROUP BY c.Cliente_idCliente;