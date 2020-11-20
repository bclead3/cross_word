# frozen_string_literal: true

describe CrossWord do
  context '#find_intersection' do
    it 'tests cat & hat' do
      # ' h '
      # 'cat'
      # ' t '
      output = CrossWord.find_intersection('cat'.split(''), 'hat'.split(''))
      expect(output).to be_a(Array)
      expect(output).to eq([1, 1])
    end

    it 'tests balloon & bat' do
      # 'balloon'
      # 'a      '
      # 't      '
      output = CrossWord.find_intersection('balloon'.split(''), 'bat'.split(''))
      expect(output).to eq([0, 0])
    end

    it 'tests faint & test' do
      # 'faint'
      # '    e'
      # '    s'
      # '    t'
      output = CrossWord.find_intersection('faint'.split(''), 'test'.split(''))
      expect(output).to eq([4, 0])
    end

    it 'tests road & dad' do
      # '  d '
      # 'road'
      # '  d '
      output = CrossWord.find_intersection('road'.split(''), 'dad'.split(''))
      expect(output).to eq([2, 1])
    end

    it 'tests dad & road' do
      # ' r '
      # ' o '
      # 'dad'
      # ' d '
      output = CrossWord.find_intersection('dad'.split(''), 'road'.split(''))
      expect(output).to eq([1, 2])
    end

    it 'tests first word nil' do
      output = CrossWord.find_intersection(nil, 'dad'.split(''))
      expect(output).to eq([])
    end

    it 'tests second word nil' do
      output = CrossWord.find_intersection('dad'.split(''), nil)
      expect(output).to eq([])
    end
  end

  context '#build_array' do
    it 'array from balloon & bat' do
      # 'balloon'
      # 'a      '
      # 't      '
      output = CrossWord.build_array('balloon', 'bat')
      expect(output).to be_a(Array)
      expect(output).to eq(['balloon', 'a      ', 't      '])
    end

    it 'array from bat & balloon' do
      output = CrossWord.build_array('bat', 'balloon')
      expect(output).to be_a(Array)
      expect(output).to eq(['bat', 'a  ', 'l  ', 'l  ', 'o  ', 'o  ', 'n  '])
    end

    it 'array from cat & hat' do
      output = CrossWord.build_array('cat', 'hat')
      expect(output).to be_a(Array)
      expect(output).to eq([' h ', 'cat', ' t '])
    end
  end

  context '#process' do
    it 'processes cat & hat' do
      expect do
        CrossWord.process('cat', 'hat')
      end.to output(" h \ncat\n t \n").to_stdout
    end

    it 'processes nil first word' do
      expect do
        CrossWord.process(nil, 'hat')
      end.to output('').to_stdout
    end

    it 'processes nil second word' do
      expect do
        CrossWord.process('cat', nil)
      end.to output('').to_stdout
    end
  end

  context '#initialize' do
    it 'processes two words' do
      expect do
        CrossWord.new 'cat', 'pat'
      end.to output("word 1 is:cat\nword 2 is:pat\n---\n p \ncat\n t \n").to_stdout
    end

    it 'processes two words, first word capitalized' do
      expect do
        CrossWord.new 'CAT', 'pat'
      end.to output("word 1 is:CAT\nword 2 is:pat\n---\n p \ncat\n t \n").to_stdout
    end

    it 'processes two words, second word capitalized' do
      expect do
        CrossWord.new 'cat', 'PAT'
      end.to output("word 1 is:cat\nword 2 is:PAT\n---\n p \ncat\n t \n").to_stdout
    end

    it 'processes one word with nothing' do
      expect do
        CrossWord.new('cat')
      end.to output('').to_stdout
    end

    it 'processes one word and one nil' do
      expect do
        CrossWord.new('cat', nil)
      end.to output("word 1 is:cat\nword 2 is:\n---\n").to_stdout
    end

    it 'processes two nil inputs' do
      expect do
        CrossWord.new(nil, nil)
      end.to output("word 1 is:\nword 2 is:\n").to_stdout
    end
  end
end
