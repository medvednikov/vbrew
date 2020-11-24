import os

// import net.http
enum Module {
	autoconf
	automake
	coreutils
}

const (
	prefix    = '/usr/local/vbrew'
	home_path = os.dir(os.executable())
)

const (
		// formulas = {
		// 'coreutils': CoreUtils{}
		// }
		// formulas = [ Formula(AutoConf{}), Formula(AutoMake{}), Formula(CoreUtils{})]
)

interface Formula {
	depends_on() []Module
	install()
	name() string
	mod() Module
	url() string
}

fn system(s string) {
	out := os.exec(s) or {
		println(err)
		exit(1)
	}
	if out.exit_code != 0 {
		println(out.output)
		exit(1)
	}
}

fn chdir(s string) {
	println('cd ' + os.join_path(home_path, s))
	if s.starts_with('/') {
		os.chdir(s)
	} else {
		os.chdir(os.join_path(home_path, s))
	}
}

fn rm(s string) {
	os.rm(s)
}

fn download_and_extract(url string, module_name string) {
	ext := url.after('.')
	tmp_path := os.join_path(home_path, 'tmp')
	archive_path := os.join_path(tmp_path, module_name + '.' + ext)
	println('Ddownloading $url')
	// http.download_file(url, file_path) or{ panic (err) }
	system('curl $url --output $archive_path')
	chdir('tmp/')
	println('extracting $archive_path')
	system('tar xf $archive_path')
	rm(archive_path)
	dirs := os.ls(tmp_path) or {
		eprintln(err)
		exit(1)
	}
	mut ok := false
	for dir in dirs {
		if dir.starts_with(module_name) {
			ok = true
			// println("renaming $dir to $module_name")
			// rename "extracted
			// os.rename(tmp_path + '/$dir', tmp_path + '/$module_name')
			// go to the newly extracted directory
			chdir(tmp_path + '/$dir')
		}
	}
	if !ok {
		eprintln('failed to extract $archive_path')
		exit(1)
	}
}

fn (app &App) install_formula(f Formula) {
	println('installing formula $f.name()')
	for dep in f.depends_on() {
		println('  installing dep $dep')
		// TODO perf
		for formula in app.formulas {
			if formula.mod() == dep {
				formula.install()
			}
		}
	}
	println('all deps installed')
	f.install()
	println('')
}

struct App {
mut:
	formulas []Formula
}

fn main() {
	mut app := &App{}
	// TODO interface bug
	// app.formulas = []Formula{}// Formula(AutoConf{}), Formula(AutoMake{}), Formula(CoreUtils{})]
	app.formulas << AutoConf{}
	app.formulas << AutoMake{}
	app.formulas << CoreUtils{}
	if os.args.len != 3 || os.args[1] != 'install' {
		eprintln("usage: 'vbrew install [package]")
		return
	}
	package := os.args[2]
	// TODO perf
	for formula in app.formulas {
		if formula.name() == package {
			// TODO interface bug
			//app.install_formula(formula)
		}
	}
	//
	f := CoreUtils{}
	app.install_formula(f)
}
