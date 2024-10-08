import 'package:liquid_engine/liquid_engine.dart';
import 'package:test/test.dart';

void main() {
  group('parser tests', () {
    test('markup only', () {
      var template = Lexer().tokenize(Source(null, 'static markup', null)).toList();

      print(template);
      expect(template, hasLength(1));
    });

    test('markup with curlies', () {
      var template = Lexer().tokenize(Source(null, "{ 'soemthing': true }", null)).toList();

      print(template);
      expect(template, hasLength(1));
    });

    test('tag only', () {
      var template = Lexer().tokenize(Source(null, '{% if %}', null)).toList();

      print(template);
      expect(template, hasLength(3));
    });

    test('whitespace control - none', () {
      var template = Lexer().tokenize(Source(null, '   {% if %}   ', null)).toList();

      print(template);
      expect(template, hasLength(5));
    });

    test('whitespace control - start', () {
      var template = Lexer().tokenize(Source(null, '   {%- if %}   ', null)).toList();

      print(template);
      expect(template, hasLength(4));
    });

    test('whitespace control - end', () {
      var template = Lexer().tokenize(Source(null, '   {% if -%}   ', null)).toList();

      print(template);
      expect(template, hasLength(4));
    });

    test('whitespace control - both', () {
      var template = Lexer().tokenize(Source(null, '   {%- if -%}   ', null)).toList();

      print(template);
      expect(template, hasLength(3));
    });

    test('var only', () {
      var template = Lexer().tokenize(Source(null, '{{ if }}', null)).toList();

      print(template);
      expect(template, hasLength(3));
    });

    test('fancy tag only', () {
      var template = Lexer().tokenize(Source(null, '{% if x | ifblank: "bob" %}', null)).toList();

      print(template);
      expect(template, hasLength(8));
    });

    test('fancy var only', () {
      var template = Lexer().tokenize(Source(null, '{{ if | append: "secrets" }}', null)).toList();

      print(template);
      expect(template, hasLength(7));
    });

    test('mixed', () {
      var template = Lexer().tokenize(Source(null, ' {% if x | ifblank: "bob" %} {{ if | append: "secrets" }} ', null)).toList();

      print(template);
      expect(template, hasLength(18));
    });
  });
}
