package wsi.parser

import wsi.core

trait IObjParser extends core.Object {

  def parse_tostring(obj: Any): String
  def content_type(): String
  def parse_object(data: String): Any
  
}