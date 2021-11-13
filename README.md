# Prime Compressor

Compress, decompress, save, and load prime number bitstrings.

## Usage

In Ruby
```ruby
bitstring = "0101000101" * 4

# Save and compress 
PrimeCompressor.zip(bitstring, "temp.bin")  

# Load and decompress
rehydrated = PrimeCompressor.unzip("temp.bin") 

# Check it
puts bitstring == rehydrated
```

In shell
```bash
hexdump temp.bin # ff
``` 