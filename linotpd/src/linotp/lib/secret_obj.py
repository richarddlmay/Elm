# -*- coding: utf-8 -*-
#
#    LinOTP - the open source solution for two factor authentication
#    Copyright (C) 2010 - 2014 LSE Leading Security Experts GmbH
#
#    This file is part of LinOTP server.
#
#    This program is free software: you can redistribute it and/or
#    modify it under the terms of the GNU Affero General Public
#    License, version 3, as published by the Free Software Foundation.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the
#               GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#    E-mail: linotp@lsexperts.de
#    Contact: www.linotp.org
#    Support: www.lsexperts.de
#
""" checks the given static password against the otpkey."""

from linotp.lib.crypt import zerome

import logging
log = logging.getLogger(__name__)


class secretPassword:

    def __init__(self, secObj):
        self.secretObject = secObj

    def checkOtp(self, anOtpVal):
        res = -1

        key = self.secretObject.getKey()

        if key == anOtpVal:
            res = 0

        zerome(key)
        del key

        return res
