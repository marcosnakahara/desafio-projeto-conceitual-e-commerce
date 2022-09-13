-- -----------------------------------------------------
-- Database ecommerce
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (idCliente))
;

-- -----------------------------------------------------
-- Table ClientePessoaFisica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ClientePessoaFisica (
  idClientePessoaFisica INT NOT NULL AUTO_INCREMENT,
  primeiroNome VARCHAR(10) NOT NULL,
  nomeMeio VARCHAR(10) NULL,
  sobrenome VARCHAR(10) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  Cliente_idCliente INT NOT NULL,
  dataNascimento DATE NOT NULL,
  PRIMARY KEY (idClientePessoaFisica),
  INDEX fk_ClientePessoaFisica_Cliente1_idx (Cliente_idCliente ASC) VISIBLE,
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE,
  UNIQUE INDEX Cliente_idCliente_UNIQUE (Cliente_idCliente ASC) VISIBLE,
  CONSTRAINT fk_ClientePessoaFisica_Cliente1
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente))
;

-- -----------------------------------------------------
-- Table Endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Endereco (
  idEndereco INT NOT NULL AUTO_INCREMENT,
  logradouro VARCHAR(45) NOT NULL,
  numero VARCHAR(45) NULL,
  complemento VARCHAR(45) NULL,
  cep VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  Cliente_idCliente INT NOT NULL,
  PRIMARY KEY (idEndereco, Cliente_idCliente),
  INDEX fk_Endereco_Cliente_idx (Cliente_idCliente ASC) VISIBLE,
  CONSTRAINT fk_Endereco_Cliente
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES ClientePessoaFisica (idClientePessoaFisica))
;

-- -----------------------------------------------------
-- Table CartaoDeCredito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS CartaoDeCredito (
  idCartaoDeCredito INT NOT NULL AUTO_INCREMENT,
  numero VARCHAR(45) NOT NULL,
  validade VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(45) NOT NULL,
  Cliente_idCliente INT NOT NULL,
  Endereco_idEndereco INT NOT NULL,
  PRIMARY KEY (idCartaoDeCredito, Cliente_idCliente, Endereco_idEndereco),
  INDEX fk_CartaoDeCredito_Cliente1_idx (Cliente_idCliente ASC) VISIBLE,
  INDEX fk_CartaoDeCredito_Endereco1_idx (Endereco_idEndereco ASC) VISIBLE,
  CONSTRAINT fk_CartaoDeCredito_Cliente1
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES ClientePessoaFisica (idClientePessoaFisica),
  CONSTRAINT fk_CartaoDeCredito_Endereco1
    FOREIGN KEY (Endereco_idEndereco)
    REFERENCES Endereco (idEndereco))
;

-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT NOT NULL AUTO_INCREMENT,
  status ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL DEFAULT 'Processando',
  descricao VARCHAR(45) NULL,
  valorfrete DECIMAL(10,2) NOT NULL,
  Cliente_idCliente INT NOT NULL,
  PRIMARY KEY (idPedido, Cliente_idCliente),
  INDEX fk_Pedido_Cliente1_idx (Cliente_idCliente ASC) VISIBLE,
  CONSTRAINT fk_Pedido_Cliente1
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente))
;

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Produto (
  idProduto INT NOT NULL AUTO_INCREMENT,
  categoria ENUM('Eletrônico','Vestuário','Brinquedo','Alimentício') NULL,
  descricao VARCHAR(45) NULL,
  valor VARCHAR(45) NOT NULL,
  PRIMARY KEY (idProduto))
;

-- -----------------------------------------------------
-- Table ItemPedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ItemPedido (
  idItemPedido INT NOT NULL AUTO_INCREMENT,
  quantidade INT NOT NULL,
  Pedido_idPedido INT NOT NULL,
  Produto_idProduto INT NOT NULL,
  PRIMARY KEY (idItemPedido, Pedido_idPedido, Produto_idProduto),
  INDEX fk_ItemPedido_Pedido1_idx (Pedido_idPedido ASC) VISIBLE,
  INDEX fk_ItemPedido_Produto1_idx (Produto_idProduto ASC) VISIBLE,
  CONSTRAINT fk_ItemPedido_Pedido1
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT fk_ItemPedido_Produto1
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto))
;

-- -----------------------------------------------------
-- Table PessoaJuridica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PessoaJuridica (
  idEmpresa INT NOT NULL AUTO_INCREMENT,
  razaoSocial VARCHAR(45) NOT NULL,
  cnpj VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEmpresa))
;

-- -----------------------------------------------------
-- Table Fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fornecedor (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  PessoaJuridica_idEmpresa INT NOT NULL,
  PRIMARY KEY (idFornecedor),
  INDEX fk_Fornecedor_PessoaJuridica1_idx (PessoaJuridica_idEmpresa ASC) VISIBLE,
  CONSTRAINT fk_Fornecedor_PessoaJuridica1
    FOREIGN KEY (PessoaJuridica_idEmpresa)
    REFERENCES PessoaJuridica (idEmpresa))
;

-- -----------------------------------------------------
-- Table ProdutoFornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ProdutoFornecedor (
  Fornecedor_idFornecedor INT NOT NULL,
  Produto_idProduto INT NOT NULL,
  PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
  INDEX fk_Fornecedor_has_Produto_Produto1_idx (Produto_idProduto ASC) VISIBLE,
  INDEX fk_Fornecedor_has_Produto_Fornecedor1_idx (Fornecedor_idFornecedor ASC) VISIBLE,
  CONSTRAINT fk_Fornecedor_has_Produto_Fornecedor1
    FOREIGN KEY (Fornecedor_idFornecedor)
    REFERENCES Fornecedor (idFornecedor),
  CONSTRAINT fk_Fornecedor_has_Produto_Produto1
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto))
;

-- -----------------------------------------------------
-- Table Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Estoque (
  idEstoque INT NOT NULL AUTO_INCREMENT,
  local VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEstoque))
;

-- -----------------------------------------------------
-- Table ProdutoEstoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ProdutoEstoque (
  Estoque_idEstoque INT NOT NULL,
  Produto_idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (Estoque_idEstoque, Produto_idProduto),
  INDEX fk_Estoque_has_Produto_Produto1_idx (Produto_idProduto ASC) VISIBLE,
  INDEX fk_Estoque_has_Produto_Estoque1_idx (Estoque_idEstoque ASC) VISIBLE,
  CONSTRAINT fk_Estoque_has_Produto_Estoque1
    FOREIGN KEY (Estoque_idEstoque)
    REFERENCES Estoque (idEstoque),
  CONSTRAINT fk_Estoque_has_Produto_Produto1
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto))
;

-- -----------------------------------------------------
-- Table EmpresaLogistica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS EmpresaLogistica (
  idEmpresaLogistica INT NOT NULL AUTO_INCREMENT,
  PessoaJuridica_idEmpresa INT NOT NULL,
  PRIMARY KEY (idEmpresaLogistica),
  INDEX fk_EmpresaLogistica_PessoaJuridica1_idx (PessoaJuridica_idEmpresa ASC) VISIBLE,
  CONSTRAINT fk_EmpresaLogistica_PessoaJuridica1
    FOREIGN KEY (PessoaJuridica_idEmpresa)
    REFERENCES PessoaJuridica (idEmpresa))
;

-- -----------------------------------------------------
-- Table Entrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Entrega (
  idEntrega INT NOT NULL AUTO_INCREMENT,
  Pedido_idPedido INT NOT NULL,
  EmpresaLogistica_idEmpresaLogistica INT NOT NULL,
  status ENUM('Coletado', 'Em transporte', 'A caminho do endereço', 'Entregue') NULL,
  codigoRastreio VARCHAR(45) NULL,
  PRIMARY KEY (idEntrega, Pedido_idPedido, EmpresaLogistica_idEmpresaLogistica),
  INDEX fk_Entrega_Pedido1_idx (Pedido_idPedido ASC) VISIBLE,
  INDEX fk_Entrega_EmpresaLogistica1_idx (EmpresaLogistica_idEmpresaLogistica ASC) VISIBLE,
  CONSTRAINT fk_Entrega_Pedido1
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT fk_Entrega_EmpresaLogistica1
    FOREIGN KEY (EmpresaLogistica_idEmpresaLogistica)
    REFERENCES EmpresaLogistica (idEmpresaLogistica))
;

-- -----------------------------------------------------
-- Table HistoricoEntrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS HistoricoEntrega (
  idHistoricoEntrega INT NOT NULL AUTO_INCREMENT,
  status ENUM('Coletado', 'Em transporte', 'A caminho do endereço', 'Entregue') NULL,
  datahora DATETIME NOT NULL,
  responsavel VARCHAR(45) NOT NULL,
  Entrega_idEntrega INT NOT NULL,
  PRIMARY KEY (idHistoricoEntrega, Entrega_idEntrega),
  INDEX fk_HistoricoEntrega_Entrega1_idx (Entrega_idEntrega ASC) VISIBLE,
  CONSTRAINT fk_HistoricoEntrega_Entrega1
    FOREIGN KEY (Entrega_idEntrega)
    REFERENCES Entrega (idEntrega))
;

-- -----------------------------------------------------
-- Table VendedorTerceiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VendedorTerceiro (
  idVendedorTerceiro INT NOT NULL AUTO_INCREMENT,
  PessoaJuridica_idEmpresa INT NOT NULL,
  PRIMARY KEY (idVendedorTerceiro),
  INDEX fk_VendedorTerceiro_PessoaJuridica1_idx (PessoaJuridica_idEmpresa ASC) VISIBLE,
  CONSTRAINT fk_VendedorTerceiro_PessoaJuridica1
    FOREIGN KEY (PessoaJuridica_idEmpresa)
    REFERENCES PessoaJuridica (idEmpresa))
;

-- -----------------------------------------------------
-- Table ProdutoTerceiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ProdutoTerceiro (
  VendedorTerceiro_idVendedorTerceiro INT NOT NULL,
  Produto_idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (VendedorTerceiro_idVendedorTerceiro, Produto_idProduto),
  INDEX fk_VendedorTerceiro_has_Produto_Produto1_idx (Produto_idProduto ASC) VISIBLE,
  INDEX fk_VendedorTerceiro_has_Produto_VendedorTerceiro1_idx (VendedorTerceiro_idVendedorTerceiro ASC) VISIBLE,
  CONSTRAINT fk_VendedorTerceiro_has_Produto_VendedorTerceiro1
    FOREIGN KEY (VendedorTerceiro_idVendedorTerceiro)
    REFERENCES VendedorTerceiro (idVendedorTerceiro),
  CONSTRAINT fk_VendedorTerceiro_has_Produto_Produto1
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto))
;

-- -----------------------------------------------------
-- Table FormaPagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS FormaPagamento (
  idFormaPagamento INT NOT NULL AUTO_INCREMENT,
  tipo ENUM('Boleto','Cartão de Crédito','Cartão de Débito','Pix') NULL,
  PRIMARY KEY (idFormaPagamento))
;

-- -----------------------------------------------------
-- Table Pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pagamento (
  idPagamento INT NOT NULL AUTO_INCREMENT,
  Pedido_idPedido INT NOT NULL,
  FormaPagamento_idFormaPagamento INT NOT NULL,
  PRIMARY KEY (idPagamento, Pedido_idPedido, FormaPagamento_idFormaPagamento),
  INDEX fk_Pagamento_Pedido1_idx (Pedido_idPedido ASC) VISIBLE,
  INDEX fk_Pagamento_FormaPagamento1_idx (FormaPagamento_idFormaPagamento ASC) VISIBLE,
  CONSTRAINT fk_Pagamento_Pedido1
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT fk_Pagamento_FormaPagamento1
    FOREIGN KEY (FormaPagamento_idFormaPagamento)
    REFERENCES FormaPagamento (idFormaPagamento))
;

-- -----------------------------------------------------
-- Table PagamentoCartaoDeCredito
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PagamentoCartaoDeCredito (
  Pagamento_idPagamento INT NOT NULL,
  CartaoDeCredito_idCartaoDeCredito INT NOT NULL,
  PRIMARY KEY (Pagamento_idPagamento, CartaoDeCredito_idCartaoDeCredito),
  INDEX fk_Pagamento_has_CartaoDeCredito_CartaoDeCredito1_idx (CartaoDeCredito_idCartaoDeCredito ASC) VISIBLE,
  INDEX fk_Pagamento_has_CartaoDeCredito_Pagamento1_idx (Pagamento_idPagamento ASC) VISIBLE,
  CONSTRAINT fk_Pagamento_has_CartaoDeCredito_Pagamento1
    FOREIGN KEY (Pagamento_idPagamento)
    REFERENCES Pagamento (idPagamento),
  CONSTRAINT fk_Pagamento_has_CartaoDeCredito_CartaoDeCredito1
    FOREIGN KEY (CartaoDeCredito_idCartaoDeCredito)
    REFERENCES CartaoDeCredito (idCartaoDeCredito))
;

-- -----------------------------------------------------
-- Table ClientePessoaJuridica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ClientePessoaJuridica (
  idClientePessoaJuridica INT NOT NULL AUTO_INCREMENT,
  PessoaJuridica_idEmpresa INT NOT NULL,
  Cliente_idCliente INT NOT NULL,
  PRIMARY KEY (idClientePessoaJuridica),
  INDEX fk_ClientePessoaJuridica_PessoaJuridica1_idx (PessoaJuridica_idEmpresa ASC) VISIBLE,
  INDEX fk_ClientePessoaJuridica_Cliente1_idx (Cliente_idCliente ASC) VISIBLE,
  CONSTRAINT fk_ClientePessoaJuridica_PessoaJuridica1
    FOREIGN KEY (PessoaJuridica_idEmpresa)
    REFERENCES PessoaJuridica (idEmpresa),
  CONSTRAINT fk_ClientePessoaJuridica_Cliente1
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente))
;