import argparse
from symmetric import SymmetricCrypto
from config import CipherLiConfig
from updater import UpdateChecker

def check_updates():
    checker = UpdateChecker()
    update_available, latest_version, latest_release_html_url = checker.check_for_updates()
    if update_available:
        print(f"\nNew version available: v{latest_version}")
        print("Release notes:")
        print(latest_release_html_url)
        print("\nRun 'git pull' to update.\n")

def main():
    if CipherLiConfig.CHECK_UPDATES:
        check_updates()

    parser = argparse.ArgumentParser(
        description=f"{CipherLiConfig.NAME} v{CipherLiConfig.VERSION} - Secure File Encryption Tool"
    )
    parser.add_argument("mode", choices=["encrypt", "decrypt"], help="Mode: encrypt or decrypt")
    parser.add_argument("password", help="Password for key derivation")
    parser.add_argument("input_file", help="Path to input file")
    parser.add_argument("output_file", help="Path to output file")
    args = parser.parse_args()

    crypto = SymmetricCrypto(args.password)

    if args.mode == "encrypt":
        crypto.encrypt_file(args.input_file, args.output_file)
        print(f"File encrypted and saved to {args.output_file}")
    elif args.mode == "decrypt":
        crypto.decrypt_file(args.input_file, args.output_file)
        print(f"File decrypted and saved to {args.output_file}")

if __name__ == "__main__":
    main()
