require 'gosu'

class Jogador
  attr_reader :placar
  def initialize (x, y)
    @imagem = Gosu::Image.new("Nave.bmp")
    @beep = Gosu::Sample.new("Beep.wav")
    @placar = 0
    @x = x
    @y = y
    @vel_x = 0
    @vel_y = 0
    @angulo = 0.0
  end

  def draw
    @imagem.draw_rot(@x, @y, 2, @angulo)
  end

  def girar_direita
    @angulo += 5.0
  end

  def girar_esquerda
    @angulo -= 5.0
  end

  def acelerar
    @vel_x += Gosu::offset_x(@angulo, 0.5)
    @vel_y += Gosu::offset_y(@angulo, 0.5)
  end

  def mover
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def cata_estrelas(estrelas)
    n_estrelas = estrelas.size
    estrelas.reject! do |estrela|
      Gosu::distance(@x, @y, estrela.x, estrela.y) < 35
    end
    n = n_estrelas - estrelas.size
    n.times do @beep.play end
    @placar += n * 10
  end
end
