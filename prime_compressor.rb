# Usage
# 	bitstring = "0101000101" * 4
# 	PrimeCompressor.zip(bitstring, "temp.bin")     # Saves and compresses.
# 	rehydrated = PrimeCompressor.unzip("temp.bin") # Loads and decompresses
# 	puts bitstring == rehydrated
module PrimeCompressor

	# string -> string
	def PrimeCompressor.file_to_bitstring(filein)
		puts "Reading file #{filein}..."
		binary = File.read(filein)
		binary.unpack("B*").first
	end

	# string, string -> nil
	def PrimeCompressor.bitstring_to_file(bitstring, fileout)
		binary = [bitstring].pack("B*")
		File.write(fileout, binary)
		puts "Wrote #{fileout}" # DEBUG
	end

	# string -> string
	# Compresses prime bitstrings by only keeping the 1st, 3rd, 
	# 7th, and 9th bits
	def PrimeCompressor.compress1379(bitstring)
		bitstring.
			scan(/.{10}/).
			map { |str| str[1] + str[3] + str[7] + str[9] }.
			join()
	end
		
	# string -> string
	# Decompresses prime bitstrings by reinserting 0's for the
	# 0th, 2nd, 4th, 5th, 6th, and 8th bits.
	def PrimeCompressor.decompress1379(bitstring)
		decomp = { 0 => 1, 1 => 3, 2 => 7, 3 => 9 }
		puts "Decompressing bitstring, this may take several minutes..."
		res = "0000000000" * (bitstring.size / 4)
		0.upto(bitstring.size - 1) do |i|
			bucket = i / 4
			rem = i % 4
			offset = decomp[rem]
			res[(bucket * 10) + offset] = bitstring[i]
		end
		res
	end

	# Convenience
	# string, string -> nil
	def PrimeCompressor.zip(bitstring, fileout)
		PrimeCompressor.bitstring_to_file(
			PrimeCompressor.compress1379(bitstring), fileout)
	end

	# Convenience
	# string -> string
	def PrimeCompressor.unzip(filein)
		PrimeCompressor.decompress1379(
			PrimeCompressor.file_to_bitstring(filein))
	end
end
