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
"""Contains SpassToken (simple pass token) class"""

import time

from linotp_selenium_helper.token import Token
from linotp_selenium_helper.helper import select

class SpassToken(Token):
    """Creates a Spass Token in the LinOTP WebUI"""

    def __init__(self,
                 driver,
                 base_url,
                 pin="",
                 description="Selenium enrolled"):
        Token.__init__(self, driver=driver, base_url=base_url)
        select_tag = driver.find_element_by_id("tokentype")
        select(driver, select_element=select_tag, option_text="Simple Pass Token")
        driver.find_element_by_id("enroll_spass_desc").clear()
        driver.find_element_by_id("enroll_spass_desc").send_keys(description)
        driver.find_element_by_id("button_enroll_enroll").click()
        time.sleep(1)
        driver.find_element_by_id("pin1").clear()
        driver.find_element_by_id("pin1").send_keys(pin)
        driver.find_element_by_id("pin2").clear()
        driver.find_element_by_id("pin2").send_keys(pin)
        driver.find_element_by_id("button_setpin_setpin").click()
        time.sleep(1)
        info_boxes = driver.find_elements_by_css_selector("#info_box > .info_box > span")
        for box in info_boxes:
            if box.text.startswith("created token with serial"):
                self.serial = box.find_element_by_tag_name("span").text
        if not self.serial or not self.serial.startswith("LSSP"):
            raise Exception("Simple pass token was not enrolled correctly.")

