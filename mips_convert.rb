typeR = ['ADD', 'SUB', 'SRA', 'SRL', 'SLL', 'AND', 'OR', 'HALT']
typeI = ['NOP', 'LB', 'SB', 'ADDI', 'ANDI', 'ORI', 
		'BEQ', 'BNE', 'BGEZ', 'BLTZ']

def regToCode(reg)
	return reg.gsub(/R/, '').to_i.to_bin(3)
end

def memToCode(input)
	parts = input.split('(')
	parts[1].gsub!(/\)/, '')
	return parts
end

class Integer
  def to_bin(width)
  	if(self >= 0)
    	'%0*b' % [width, self]
    else
    	num = '%0*b' % [width, -1*self]
        invNum = ''
    	num.each_char do |c|
    		if c == '0'
    			invNum = invNum + '1'
    		else
    			invNum = invNum + '0'
    		end
    	end
    	return (invNum.to_i(2) + 1).to_s(2)
    end
  end
end

###### CODE ######

if ARGV.length < 1
	puts "No input file specified."
	exit
end

lines = File.foreach(ARGV[0])

commands = []

i = 0
lines.each do |line|
	line.chomp!
	if line != ''
		commands[i] = line.split
		commands[i].each do |cmd|
			cmd.chomp!(',')
		end
		i += 1
	end
end

commands.each do |cmd|
	if typeR.include?(cmd[0])
		op = '1111'
		rs = '000'
		rt = '000'
		rd = '000'
		funct = '000'
		case cmd[0]
		when 'ADD'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			rt = regToCode(cmd[3])
			funct = '000'
		when 'SUB'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			rt = regToCode(cmd[3])
			funct = '001'
		when 'SRA'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			funct = '010'
		when 'SRL'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			funct = '011'
		when 'SLL'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			funct = '100'
		when 'AND'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			rt = regToCode(cmd[3])
			funct = '101'
		when 'OR'
			rd = regToCode(cmd[1])
			rs = regToCode(cmd[2])
			rt = regToCode(cmd[3])
			funct = '110'
		when 'HALT'
			op = '0000'
			rs = '000'
			rt = '000'
			rd = '000'
			funct = '001'
		else
			print "BAD OP"
		end
		puts "#{op}#{rs}#{rt}#{rd}#{funct}"
	elsif typeI.include?(cmd[0])
		op = '0000'
		rs = '000'
		rt = '000'
		imm = '000000'
		case cmd[0]
			when 'NOP'
				op = '0000'
				rs = '000'
				rt = '000'
				imm = '000000'
			when 'LB'
				data = memToCode(cmd[2])
				op = '0010'
				rs = regToCode(data[1])
				rt = regToCode(cmd[1])
				imm = data[0].to_i.to_bin(6)
			when 'SB'
				data = memToCode(cmd[2])
				op = '0100'
				rs = regToCode(data[1])
				rt = regToCode(cmd[1])
				imm = data[0].to_i.to_bin(6)
			when 'ADDI'
				op = '0101'
				rs = regToCode(cmd[2])
				rt = regToCode(cmd[1])
				imm = cmd[3].to_i.to_bin(6)
			when 'ANDI'
				op = '0110'
				rs = regToCode(cmd[2])
				rt = regToCode(cmd[1])
				imm = cmd[3].to_i.to_bin(6)
			when 'ORI'
				op = '0111'
				rs = regToCode(cmd[2])
				rt = regToCode(cmd[1])
				imm = cmd[3].to_i.to_bin(6)
			when 'BEQ'
				op = '1000'
				rt = regToCode(cmd[2])
				rs = regToCode(cmd[1])
				imm = cmd[3].to_i.to_bin(6)
			when 'BNE'
				op = '1001'
				rt = regToCode(cmd[2])
				rs = regToCode(cmd[1])
				imm = cmd[3].to_i.to_bin(6)
			when 'BGEZ'
				op = '1010'
				rs = regToCode(cmd[1])
				rt = '000'
				imm = cmd[2].to_i.to_bin(6)
			when 'BLTZ'
				op = '1011'
				rs = regToCode(cmd[1])
				rt = '000'
				imm = cmd[2].to_i.to_bin(6)
		end
		puts "#{op}#{rs}#{rt}#{imm}"
	else
		puts "BAD OP"
	end
end