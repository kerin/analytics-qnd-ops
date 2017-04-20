from group import Group

import requests


class GroupAPI(object):

    def __init__(self, authz_api, authz_token, logger):
        self.authz_api = authz_api
        self.authz_token = authz_token
        self.log = logger

    def create(self, group_name):
        group_data = self._get_group(group_name)
        if not group_data:
            group_data = self._create_group(group_name)

        return Group(self.authz_api, self.authz_token, self.log, group_data)

    def _get_all(self):
        # Get existing groups
        resp = requests.get(
            '{}/groups'.format(self.authz_api),
            headers={
                "Authorization": "Bearer {}".format(self.authz_token)
            }
        )
        if resp.status_code != 200:
            self.log.error("Failed to get groups: expected 200, got {}: {}".format(resp.status_code, resp.text))
            return None

        return resp.json()['groups']


    def _get_group(self, group_name):
        groups = self._get_all()
        for group in groups:
            if group['name'] == group_name:
                return group
        return None


    def _create_group(self, group_name):
        # Create new group
        resp = requests.post(
            '{}/groups'.format(self.authz_api),
            headers={
                "Authorization": "Bearer {}".format(self.authz_token),
            },
            json={
              'name': group_name,
              'description': group_name,
            }
        )
        if resp.status_code != 200:
            self.log.error("Failed to create group: expected 200, got {}: {}".format(resp.status_code, resp.text))
            return None
        group = resp.json()

        self.log.debug("Group created = {}".format(group))
        return group

