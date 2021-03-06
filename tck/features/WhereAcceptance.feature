#
# Copyright 2016 "Neo Technology",
# Network Engine for Objects in Lund AB (http://neotechnology.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Feature: WhereAcceptance

  Scenario: NOT and false
    Given an empty graph
    And having executed:
      """
      CREATE ({name: 'a'})
      """
    When executing query:
      """
      MATCH (n)
      WHERE NOT(n.name = 'apa' AND false)
      RETURN n
      """
    Then the result should be:
      | n             |
      | ({name: 'a'}) |
    And no side effects

  Scenario: Fail when trying to compare strings and numbers
    Given an empty graph
    And having executed:
      """
      CREATE (:Label {prop: '15'})
      """
    When executing query:
      """
      MATCH (n:Label)
      WHERE n.prop < 10
      RETURN n.prop AS prop
      """
    Then a TypeError should be raised at runtime: IncomparableValues
