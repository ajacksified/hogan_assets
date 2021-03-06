require 'test_helper'

module HoganAssets
  class TiltTest < Test::Unit::TestCase
    def test_mime_type
      assert_equal 'application/javascript', HoganAssets::Tilt.default_mime_type
    end

    def test_render
      scope = Class.new do
        def logical_path ; 'path/to/template' ; end
      end.new

      template = HoganAssets::Tilt.new('/myapp/app/assets/templates/path/to/template.mustache') { "This is {{mustache}}" }
      assert_equal <<-END_EXPECTED, template.render(scope, {})
        this.HoganTemplates || (this.HoganTemplates = {});
        this.HoganTemplates[\"path/to/template\"] = new Hogan.Template(function(c,p,i){var _=this;_.b(i=i||\"\");_.b(\"This is \");_.b(_.v(_.f(\"mustache\",c,p,0)));return _.fl();;});
      END_EXPECTED
    end
  end
end
