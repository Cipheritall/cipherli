from typing import Tuple
import requests
from config import CipherLiConfig
from packaging import version

class UpdateChecker:
    def __init__(self):
        self.current_version = CipherLiConfig.VERSION
        self.repo_url = CipherLiConfig.GITHUB_API_URL

    def check_for_updates(self) -> Tuple[bool, str, str]:
        """
        Checks if a new version is available
        Returns: (update_available, latest_version, changelog)
        """
        try:
            response = requests.get(self.repo_url, timeout=5)
            if response.status_code == 200:
                latest_release = response.json()[0]
                latest_version = latest_release['tag_name'].lstrip('v')
                changelog = latest_release['body']
                
                if version.parse(latest_version) > version.parse(self.current_version):
                    return True, latest_version, changelog
            
            return False, self.current_version, ""
            
        except Exception:
            return False, self.current_version, ""
