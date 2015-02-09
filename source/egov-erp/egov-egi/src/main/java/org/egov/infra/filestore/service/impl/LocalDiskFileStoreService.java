package org.egov.infra.filestore.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import org.egov.exceptions.EGOVRuntimeException;
import org.egov.infra.filestore.FileStoreMapper;
import org.egov.infra.filestore.service.FileStoreService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component("localDiskFileStoreService")
public class LocalDiskFileStoreService implements FileStoreService {

    private static final Logger LOG = LoggerFactory.getLogger(LocalDiskFileStoreService.class);
    
    private final String fileStorePath;

    @Autowired
    public LocalDiskFileStoreService(@Value("#{egovErpProperties.fileStorePath}")final String fileStorePath) {
        this.fileStorePath = fileStorePath;
    }

    @Override
    public FileStoreMapper store(final File sourceFile, final String moduleName) {
        try {
            final FileStoreMapper fileMapper = new FileStoreMapper(UUID.randomUUID(), sourceFile.getName(), moduleName);
            Files.copy(sourceFile.toPath(), createNewFilePath(fileMapper, moduleName));
            return fileMapper;
        } catch (final IOException e) {
            throw new EGOVRuntimeException("Error occurred while storing files at " + fileStorePath, e);
        }
    }

    @Override
    public FileStoreMapper store(final InputStream sourceFileStream, final String moduleName) {
        try {
            final FileStoreMapper fileMapper = new FileStoreMapper(UUID.randomUUID(),"noname", moduleName);
            Files.copy(sourceFileStream, createNewFilePath(fileMapper, moduleName));
            return fileMapper;
        } catch (final IOException e) {
            throw new EGOVRuntimeException("Error occurred while storing files at " + fileStorePath, e);
        }
    }

    @Override
    public Set<FileStoreMapper> store(final Set<File> files, final String moduleName) {
        return files.stream().map((file) -> store(file, moduleName)).collect(Collectors.toSet());
    }

    @Override
    public Set<FileStoreMapper> storeStreams(final Set<InputStream> fileStreams, final String moduleName) {
        return fileStreams.stream().map((fileStream) -> store(fileStream, moduleName)).collect(Collectors.toSet());
    }

    @Override
    public File fetch(final FileStoreMapper fileMapper) {
        final Path path = Paths.get(fileStorePath + File.separator + fileMapper.getModuleName());
        if (!Files.exists(path))
            throw new EGOVRuntimeException("File Store does not exist at Path : " + fileStorePath);
        return Paths.get(path.toString() + File.separator + fileMapper.getFileStoreId().toString()).toFile();
    }

    @Override
    public Set<File> fetchAll(final Set<FileStoreMapper> fileMappers) {
        return fileMappers.stream().map((fileMapper) -> fetch(fileMapper)).collect(Collectors.toSet());
    }

    private Path createNewFilePath(final FileStoreMapper fileMapper, final String moduleName) throws IOException {
        final Path fileStoreDir = Paths.get(fileStorePath + File.separator + moduleName);
        if (!Files.exists(fileStoreDir)) {
            LOG.info("File Store Directory {} not found, creating one", fileStorePath);
            Files.createDirectories(fileStoreDir);
            LOG.info("Created File Store Directory {}", fileStorePath);
        }
        return Paths.get(fileStoreDir.toString() + File.separator + fileMapper.getFileStoreId());
    }
}
