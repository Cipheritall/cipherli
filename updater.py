from typing import Tuple
import requests
from config import CipherLiConfig
from packaging import version
import os
import sys

class UpdateChecker:
    def __init__(self):
        self.current_version = CipherLiConfig.VERSION
        self.repo_url = CipherLiConfig.GITHUB_API_URL

    def check_for_updates(self) -> Tuple[bool, str, str]:
        """
        Checks if a new version is available
        Returns: (update_available, latest_version, release_notes_url)
        """
        try:
            response = requests.get(self.repo_url, timeout=5)
            if response.status_code == 200:
                latest_release = response.json()[0]
                latest_version = latest_release['tag_name'].lstrip('v')
                release_notes_url = latest_release['html_url']

                if version.parse(latest_version) > version.parse(self.current_version):
                    return True, latest_version, release_notes_url

            return False, self.current_version, ""
            
        except Exception:
            return False, self.current_version, ""

    def execute_update(self) -> None:
        """Execute the update process using the get.sh script"""
        print("\nUpdating CipherLi...")
        update_command = f"wget -qO- {CipherLiConfig.GET_SCRIPT_URL} | sh"
        os.system(update_command)
        sys.exit(0)

    def prompt_and_update(self) -> None:
        """Check for updates and prompt user if available"""
        update_available, latest_version, latest_release_html_url = self.check_for_updates()
        if update_available:
            print(f"\nNew version {latest_version} available!")
            print(f"Current version: {self.current_version}")
            print(f"Release notes: {latest_release_html_url}")
            
            response = input("\nWould you like to update? [y/N]: ").strip().lower()
            if response in ['y', 'yes']:
                self.execute_update()
            else:
                print("Update skipped. Continuing with current version.\n")
