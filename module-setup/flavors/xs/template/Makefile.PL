use inc::Module::Install;
use Module::Install::XSUtil;
use Module::Install::MicroTemplate;
use Module::Install::Repository;

name '[% dist %]';
all_from 'lib/[% module_unix_path %].pm';

# XXX: for auto detecting target XS files.
sub render_mt_hack {
    my ($src, $dst) = @_;

    # generate dummmy file
    if ( ! -e $dst ) {
        warn "generate $dst";
        open(my $fh, '>', $dst);
        close $fh;
    }
    utime 0, 0, $dst;
    render_mt $src, $dst;
}

render_mt_hack '[% module %].mtxs' => '[% module %].xs';

cc_warnings;
use_ppport 3.19;

tests_recursive 't';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;

postamble(<<END_POSTAMBLE);

*.xs\$(OBJ_EXT) :: *.xs


*.xs.c :: *.xs



END_POSTAMBLE

auto_set_repository;

WriteAll;
