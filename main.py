import argparse
from symmetric import SymmetricCrypto
from config import CipherLiConfig

def main():
    parser = argparse.ArgumentParser(description=f"{CipherLiConfig.NAME} {CipherLiConfig.VERSION} - File encryption/decryption tool")
    parser.add_argument("mode", choices=["encrypt", "decrypt"], help="Mode: encrypt or decrypt")
    parser.add_argument("password", help="Password for key derivation")
    parser.add_argument("input_file", help="Path to input file")
    parser.add_argument("output_file", help="Path to output file")
    args = parser.parse_args()

    crypto = SymmetricCrypto(args.password)

    if args.mode == "encrypt":
        crypto.encrypt_file(args.input_file, args.output_file)
        print(f"File encrypted and saved to {args.output_file}")
    else:
        crypto.decrypt_file(args.input_file, args.output_file)
        print(f"File decrypted and saved to {args.output_file}")

if __name__ == "__main__":
    main()
