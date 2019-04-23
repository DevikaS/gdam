package com.adstream.automate.babylon
package performance.utils

object TeamcityUtils {
  def teamcityLog(str: String): Unit = println(s"##teamcity[$str]")

  def teamcityEscape(str: String): String = Option(str).fold("<NULL>")(_.collect {
    case '\'' => "|'"
    case '\n' => "|n"
    case '\r' => "|r"
    case '|' => "||"
    case '[' => "|["
    case ']' => "|]"
    case v => v.toString
  }.mkString)
}
