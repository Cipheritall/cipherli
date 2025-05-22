import argparse
import os
import sys
from symmetric import SymmetricCrypto
from config import CipherLiConfig
from updater import UpdateChecker

def check_updates():
    checker = UpdateChecker()
    checker.prompt_and_update()

def main():
    if CipherLiConfig.CHECK_UPDATES:
        check_updates()

    parser = argparse.ArgumentParser(
        description=f"{CipherLiConfig.NAME} v{CipherLiConfig.VERSION} - Secure File Encryption Tool"
    )
    parser.add_argument("mode", choices=["encrypt", "decrypt"], help="Mode: encrypt or decrypt")
    parser.add_argument("password", help="Password for key derivation")
    parser.add_argument("input", help="Path to input file or folder")
    parser.add_argument("output", help="Path to output file or folder")
    parser.add_argument("-r", "--recursive", action="store_true", help="Process directories recursively")
    args = parser.parse_args()

    crypto = SymmetricCrypto(args.password)

    if os.path.isdir(args.input):
        if args.mode == "encrypt":
            crypto.encrypt_folder(args.input, args.output, args.recursive)
            print(f"Folder encrypted and saved to {args.output}")
        else:
            crypto.decrypt_folder(args.input, args.output, args.recursive)
            print(f"Folder decrypted and saved to {args.output}")
    else:
        if args.mode == "encrypt":
            crypto.encrypt_file(args.input, args.output)
            print(f"File encrypted and saved to {args.output}")
        else:
            crypto.decrypt_file(args.input, args.output)
            print(f"File decrypted and saved to {args.output}")

if __name__ == "__main__":
    main()
