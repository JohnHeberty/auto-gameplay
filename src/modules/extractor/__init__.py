import bz2
import os
import zipfile
import tarfile

try:
    import rarfile
    _RARFILE_AVAILABLE = True
except ImportError:
    _RARFILE_AVAILABLE = False

class BZ2Extractor:
    """
    Extrai arquivos .bz2 para um diretório de destino.
    """
    def __init__(self, source_path, dest_dir):
        self.source_path = source_path
        self.dest_dir = dest_dir

    def extract(self):
        """
        Extracts a .bz2 compressed file to the specified destination directory.

        If the destination directory does not exist, it will be created. The method 
        reads the source .bz2 file in chunks and writes the decompressed data to a 
        file with the same name (minus the .bz2 extension) in the destination directory.

        Returns:
            str: The path to the extracted file.

        Raises:
            ValueError: If the source file does not have a .bz2 extension.
        """
        if not os.path.exists(self.dest_dir):
            os.makedirs(self.dest_dir)
        filename = os.path.basename(self.source_path)
        if filename.endswith('.bz2'):
            out_file = os.path.join(self.dest_dir, filename[:-4])
            with bz2.open(self.source_path, 'rb') as f_in:
                with open(out_file, 'wb') as f_out:
                    for data in iter(lambda: f_in.read(1024 * 1024), b''):
                        f_out.write(data)
                    f_out.flush()
            return out_file
        else:
            raise ValueError("O arquivo não é um .bz2 válido.")

class ZipExtractor:
    """
    Extrai arquivos .zip para um diretório de destino.
    """
    def __init__(self, source_path, dest_dir):
        self.source_path = source_path
        self.dest_dir = dest_dir

    def extract(self):
        """
        Extracts a .zip compressed file to the specified destination directory.

        If the destination directory does not exist, it will be created. The method 
        uses the zipfile module to extract all files in the zip archive to the 
        destination directory.

        Returns:
            str: The path to the directory where files were extracted.

        Raises:
            ValueError: If the source file does not have a .zip extension or is not a valid zip file.
        """
        if not zipfile.is_zipfile(self.source_path):
            raise ValueError("O arquivo não é um .zip válido.")
        with zipfile.ZipFile(self.source_path, 'r') as zip_ref:
            zip_ref.extractall(self.dest_dir)
            zip_ref.close()
        return self.dest_dir

class TarExtractor:
    """
    Extrai arquivos .tar, .tar.gz, .tgz, .tar.bz2 para um diretório de destino.
    """
    def __init__(self, source_path, dest_dir):
        self.source_path = source_path
        self.dest_dir = dest_dir

    def extract(self):
        """
        Extracts a .tar, .tar.gz, .tgz, or .tar.bz2 compressed file to the specified destination directory.

        If the destination directory does not exist, it will be created. The method 
        uses the tarfile module to extract all files in the tar archive to the 
        destination directory.

        Returns:
            str: The path to the directory where files were extracted.

        Raises:
            ValueError: If the source file does not have a valid tar extension or is not a valid tar file.
        """
        if not tarfile.is_tarfile(self.source_path):
            raise ValueError("O arquivo não é um .tar válido.")
        with tarfile.open(self.source_path, 'r:*') as tar:
            tar.extractall(self.dest_dir)
            tar.close()
        return self.dest_dir

class RarExtractor:
    """
    Extrai arquivos .rar para um diretório de destino.
    """
    def __init__(self, source_path, dest_dir):
        if not _RARFILE_AVAILABLE:
            raise ImportError("rarfile não está instalado. Instale com 'pip install rarfile'.")
        self.source_path = source_path
        self.dest_dir = dest_dir

    def extract(self):
        """
        Extracts a .rar compressed file to the specified destination directory.

        If the destination directory does not exist, it will be created. The method 
        uses the rarfile module to extract all files in the rar archive to the 
        destination directory.

        Returns:
            str: The path to the directory where files were extracted.

        Raises:
            ValueError: If the source file does not have a .rar extension or is not a valid rar file.
        """
        if not rarfile.is_rarfile(self.source_path):
            raise ValueError("O arquivo não é um .rar válido.")
        with rarfile.RarFile(self.source_path) as rar:
            rar.extractall(self.dest_dir)
            rar.close()
        return self.dest_dir

# Exemplo de uso:
# bz2_extractor = BZ2Extractor('caminho/para/arquivo.bz2', 'diretorio/destino')
# bz2_extractor.extract()
# zip_extractor = ZipExtractor('caminho/para/arquivo.zip', 'diretorio/destino')
# zip_extractor.extract()
# tar_extractor = TarExtractor('caminho/para/arquivo.tar.gz', 'diretorio/destino')
# tar_extractor.extract()
# rar_extractor = RarExtractor('caminho/para/arquivo.rar', 'diretorio/destino')
# rar_extractor.extract()