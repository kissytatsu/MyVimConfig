タイトル通り、neovim＆dein.vimのインストールその他諸々手こずったのでメモ  
@ Bash on Ubuntu on Windows  
#Install NeoVim
- 現時点ではubuxtuのパッケージリストに追加されてないのでppaに追加  

```
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim
```

- denite.vimでPython3も要求されるのでついでにインストール  

```
sudo apt-get -y install python-dev python-pip python3-dev python3-pip
```

##About Config File
- vimでは設定ファイルは~/.vimrcだったが、neovimでは[XDG Base Directory](https://wiki.archlinuxjp.org/index.php/XDG_Base_Directory_サポート)を採用しているので  
~/.bashrcに`XDG_CONFIG_HOME=hoge`を書く    
なので設定ファイルはhoge/nvim/init.vimになるのだが、

- ここで、hoge/nvimの/nvimは__名前変更してはいけない！！__  
自分はわかりやすいように/nvim_deinとかに書き換えて、  
「あれ？設定ファイル読み込まれてない？」ってなりました(泣)  

#Install Dein.vim
```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
```  

- そしてこのinstaller.shは引数にインストールディレクトリを指定する必要がある  
~/.cache/deinにインストールするのが一般的らしいので  

```
mkdir -p ~/.cache/dein
sh /installer.shのあるディレクトリ/installer.sh ~/.cache/dein
```  

-  installer.shを実行した時に表示される文字列`"dein Scripts----`以下を`XDG_CONFIG_HOME/nvim/init.d`にコピべ   

- この`"dein Scripts----以下`の最後の3行  
```
"if dein#check_install()  
" call dein#install()  
"endif  
```
はコメントアウトしておく(プラグインを自動インストールさせるため)  

- あとはneovimを起動すればインストールが始まる

#Dein Config Files

- init.vimの"dein Scripts----以下に色々書くのだが、そのサンプルはいろいろなブログで公開されてる

- そしてとても初歩的なことだが、最初にコピベでくっつけたものは消してもいいのか？と思った  
    - 結果、最初にコピべしたのは最初にインストールするプラグインが書かれていて、さらに公開されているサンプルに必要なものが書かれているので消してもよかった
      
##toml files  
 - プラグインをtomlファイルで一括で管理できる
 
- tomlを使うには、以下をinit.vimに書く必要がある  
```
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml = s:dein_config_dir . '/dein.toml'
  let s:toml_lazy = s:dein_config_dir . '/dein_lazy.toml'
  
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})
  
  call dein#end()
  call dein#save_state()
endif
```
