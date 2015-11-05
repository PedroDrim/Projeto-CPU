#=======================================================#
class Contrato
  
  attr_reader :comando
  attr_reader :descricao
  attr_reader :parametros
  attr_reader :state
  
  #=======================================================#
  def initialize(comando,descricao,parametros,state)  
    
    raise 'O comando possui espaços em branco.' unless comando.match(/\s/).nil?    
    @comando = comando
    raise 'A quantidade de parametros possui letras.' unless parametros.is_a? Numeric    
    @parametros = parametros
    raise 'A tipo de parametros possui letras' unless parametros.is_a? Numeric    
    @state = state
    
    @descricao = descricao  
  end
  #=======================================================#
  
  #=======================================================#
  def to_s
    
    resposta = "comando: #{@comando}.\n"
    resposta << "parametros: #{@parametros}.\n"
    resposta << "state: #{@state}.\n"
    resposta << "descrição: #{@descricao}.\n"
    
    return resposta
  end
  #=======================================================#
  
end
#=======================================================#
