from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import os
import shutil
from pathlib import Path
from cryptography.fernet import Fernet
import base64

class SymmetricCrypto:
    def __init__(self, password: str):
        self.password = password.encode()
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=b'fixed-salt',  # In production, use a random salt
            iterations=480000,
        )
        key = base64.urlsafe_b64encode(kdf.derive(password.encode()))
        self.fernet = Fernet(key)

    def encrypt_file(self, input_path, output_path):
        salt = os.urandom(16)
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
        )
        key = kdf.derive(self.password)
        iv = os.urandom(12)
        cipher = Cipher(algorithms.AES(key), modes.GCM(iv))
        encryptor = cipher.encryptor()
        with open(input_path, 'rb') as f:
            data = f.read()
        encrypted_data = encryptor.update(data) + encryptor.finalize()
        with open(output_path, 'wb') as f:
            f.write(salt + iv + encryptor.tag + encrypted_data)

    def decrypt_file(self, input_path, output_path):
        with open(input_path, 'rb') as f:
            file_data = f.read()
        salt = file_data[:16]
        iv = file_data[16:28]
        tag = file_data[28:44]
        encrypted_data = file_data[44:]
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
        )
        key = kdf.derive(self.password)
        cipher = Cipher(algorithms.AES(key), modes.GCM(iv, tag))
        decryptor = cipher.decryptor()
        decrypted_data = decryptor.update(encrypted_data) + decryptor.finalize()
        with open(output_path, 'wb') as f:
            f.write(decrypted_data)

    def encrypt_folder(self, input_folder, output_folder, recursive=False):
        input_path = Path(input_folder)
        output_path = Path(output_folder)
        
        if not output_path.exists():
            output_path.mkdir(parents=True)
        
        for item in input_path.iterdir():
            output_item = output_path / item.name
            
            if item.is_file():
                self.encrypt_file(str(item), str(output_item) + '.enc')
            elif item.is_dir() and recursive:
                self.encrypt_folder(str(item), str(output_item), recursive)

    def decrypt_folder(self, input_folder, output_folder, recursive=False):
        input_path = Path(input_folder)
        output_path = Path(output_folder)
        
        if not output_path.exists():
            output_path.mkdir(parents=True)
        
        for item in input_path.iterdir():
            if item.is_file():
                if item.name.endswith('.enc'):
                    output_item = output_path / item.name[:-4]  # remove .enc
                    self.decrypt_file(str(item), str(output_item))
            elif item.is_dir() and recursive:
                output_item = output_path / item.name
                self.decrypt_folder(str(item), str(output_item), recursive)