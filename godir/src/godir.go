package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func main() {
	// Criar os seguintes diretórios
	dirs := [4]string{"bin", "src", "assets", "docs"}
	// Iterar no array, criar os diretórios dentro do diretório base Args[0]
	// 0755 é a permissão padrão dos arquivos em ambiente Unix-like
	if _, err := os.Stat(os.Args[1]); os.IsNotExist(err) {
		for x := 0; x < len(dirs); x++ {
			os.MkdirAll(os.Args[1]+"/"+dirs[x], 0755)
		}
	} else {
		fmt.Println("\nDiretório já existe! Tente outro nome\n")
	}

	// Mesangem padrão dentro do arquivo main.go do projeto
	mainMessage := ("package main\n\nimport \"fmt\"\n\nfunc main() {\n\tfmt.Println(\"Hello World!\")\n}")

	ioutil.WriteFile(os.Args[1]+"/main.go", []byte(mainMessage), 0755)

}
