package org.genvisis.one.JL.fcs;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.genvisis.CLI;
import org.genvisis.common.ArrayUtils;
import org.genvisis.common.CmdLine;
import org.genvisis.common.Files;
import org.genvisis.common.HashVec;
import org.genvisis.common.Logger;
import org.genvisis.common.PSF;
import org.genvisis.common.ext;
import org.genvisis.qsub.Qsub;
import org.genvisis.stats.Rscript;

/**
 * Class for setting up runs of OpenCyto
 *
 */
public class OpenCyto {

	private static final String OPEN_CYTO_BATCH = "openCytoBatch_";
	private static final String GENVISIS = "genvisis";
	private static final String BATCH = "batch";
	private static final String TEMPLATE_MONOCYTE = "templateMonocyte";
	private static final String TEMPLATE_LYMPH = "templateLymph";
	private static final String INPUT_FCS = "inputFCS";
	private static final String R_SOURCE = "rSource";
	private static final String PANEL_1_MAP = "panel1Map";
	private static final String PANEL_2_MAP = "panel2Map";
	private static final String FCS_WSP_MAP = "mapFile";

	private OpenCyto() {

	}

	private static String addQ(String orig) {
		return "\"" + orig + "\"";
	}

	private static String prepRscript(CLI c, String batchFile, Logger log) {
		String[] rscript = HashVec.loadFileToStringArray(c.get(R_SOURCE), false, null, false);
		String batchOut = c.get(CLI.ARG_OUTDIR) + ext.rootOf(batchFile) + "/";
		String gateDir = batchOut + "gates/";
		new File(gateDir).mkdirs();
		String gateQCDir = batchOut + "gatesQC/";
		new File(gateQCDir).mkdirs();
		String fcsQCDir = batchOut + "fcsQC/";
		new File(fcsQCDir).mkdirs();

		for (int i = 0; i < rscript.length; i++) {
			if (rscript[i].startsWith("inputDir = ")) {
				rscript[i] = "inputDir = " + addQ(c.get(INPUT_FCS));
			} else if (rscript[i].startsWith("panle1mapFile =")) {
				rscript[i] = "panle1mapFile =" + addQ(c.get(PANEL_1_MAP));
			} else if (rscript[i].startsWith("panle2mapFile =")) {
				rscript[i] = "panle2mapFile =" + addQ(c.get(PANEL_2_MAP));
			} else if (rscript[i].startsWith("outputDir =")) {
				rscript[i] = "outputDir =" + addQ(batchOut);
			} else if (rscript[i].startsWith("templateLymph =")) {
				rscript[i] = "templateLymph =" + addQ(c.get(TEMPLATE_LYMPH));
			} else if (rscript[i].startsWith("templateMono =")) {
				rscript[i] = "templateMono =" + addQ(c.get(TEMPLATE_MONOCYTE));
			} else if (rscript[i].startsWith("mapperFile =")) {
				rscript[i] = "mapperFile =" + addQ(c.get(FCS_WSP_MAP));
			} else if (rscript[i].startsWith("REPLACE_FOR_NEW_FILES =")) {
				String[] inputFiles = getInput(batchFile, log);
				List<String> toUse = new ArrayList<>();
				List<String> notToUse = new ArrayList<>();

				for (int j = 0; j < inputFiles.length; j++) {
					if (!inputFiles[j].contains("Compensation Controls")) {
						toUse.add(ext.removeDirectoryInfo(inputFiles[j]));
					} else {
						notToUse.add(inputFiles[j]);
					}
				}
				Files.writeIterable(notToUse, ext.rootOf(batchFile, false) + "_sampleNotUsed.txt");

				rscript[i] = "fcsFilesAll =" + Rscript.generateRVector(ArrayUtils.toStringArray(toUse), true);
			}
		}
		return ArrayUtils.toStr(rscript, "\n");

	}

	private static void run(CLI c) {

		String outDir = c.get(CLI.ARG_OUTDIR);
		new File(outDir).mkdirs();
		Logger log = new Logger(outDir + ext.rootOf(c.get(R_SOURCE)) + ".log");

		List<String> cmd = new ArrayList<>();
		cmd.add("Rscript");
		cmd.add(c.get(R_SOURCE));

		List<String> necessaryInputFiles = new ArrayList<>();
		necessaryInputFiles.add(c.get(R_SOURCE));
		List<String> expectedOutputFiles = new ArrayList<>();
		CmdLine.runCommandWithFileChecks(cmd, "", necessaryInputFiles, expectedOutputFiles, true, true, false, false,
				log);

	}

	private static void batch(CLI c) {
		String outDir = c.get(CLI.ARG_OUTDIR);
		new File(outDir).mkdirs();
		Logger log = new Logger(outDir + "openCytoBatch.log");
		List<String> cmd = new ArrayList<>();

		cmd.add("java");
		cmd.add("-jar");
		cmd.add(c.get(GENVISIS));
		cmd.add(OpenCyto.class.getName());
		cmd.add(CLI.ARG_OUTDIR + "=" + outDir);
		cmd.add(TEMPLATE_LYMPH + "=" + c.get(TEMPLATE_LYMPH));
		cmd.add(TEMPLATE_MONOCYTE + "=" + c.get(TEMPLATE_MONOCYTE));
		cmd.add(CLI.ARG_THREADS + "=" + c.getI(CLI.ARG_THREADS));
		cmd.add(PANEL_1_MAP + "=" + c.get(PANEL_1_MAP));
		cmd.add(PANEL_2_MAP + "=" + c.get(PANEL_2_MAP));

		int batch = c.getI(BATCH);
		if (batch < 1) {
			throw new IllegalArgumentException(BATCH + " argument must be set to greater than 1");
		}

		String input = c.get(INPUT_FCS);

		String[] inputFiles = getInput(input, log);

		String[][] batches = ArrayUtils.splitUpStringArray(inputFiles, batch, log);
		for (int i = 0; i < batches.length; i++) {
			String batchFile = outDir + OPEN_CYTO_BATCH + i + ".txt";
			String pbs = outDir + OPEN_CYTO_BATCH + i + ".pbs";
			String rscript = outDir + OPEN_CYTO_BATCH + i + ".RScript";
			Files.writeArray(batches[i], batchFile);
			List<String> currentCmd = new ArrayList<>();
			currentCmd.addAll(cmd);
			currentCmd.add(INPUT_FCS + "=" + batchFile);
			currentCmd.add(R_SOURCE + "=" + rscript);

			Files.write(prepRscript(c, batchFile, log), rscript);
			Qsub.qsub(pbs,
					"module load R/3.3.3\nmodule load gcc/6.1.0\nmodule load hdf5/hdf5-1.8.9-intel\n"
							+ ArrayUtils.toStr(currentCmd, " "),
					c.getI(PSF.Ext.MEMORY_MB), c.getI(PSF.Ext.WALLTIME_HRS), c.getI(CLI.ARG_THREADS));

		}
		log.reportTimeInfo("Found " + inputFiles.length + " .fcs files in " + input);
	}

	private static String[] getInput(String input, Logger log) {
		if (Files.isDirectory(input)) {
			log.reportTimeInfo("Assuming " + input + " is a directory, finding all files with .fcs extension");
			String[] allFiles = Files.listAllFilesInTree(input, false);
			List<String> fcsFiles = new ArrayList<>();
			for (String file : allFiles) {
				if (file.endsWith(".fcs")) {
					fcsFiles.add(file);
				}
			}
			log.reportTimeInfo("found " + fcsFiles.size() + " fcs files under " + input);
			return ArrayUtils.toStringArray(fcsFiles);

		} else if (Files.exists(input)) {
			return HashVec.loadFileToStringArray(input, false, null, true);
		} else {
			throw new IllegalArgumentException(input + " does not exist");

		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		CLI c = new CLI(OpenCyto.class);
		c.addArgWithDefault(GENVISIS, "full path to genvisis jar to use", "~/genvisis.jar");
		c.addArgWithDefault(R_SOURCE, "full path to R source file for running openCyto", "~/src/openCytoSrc.R");
		c.addArgWithDefault(INPUT_FCS, "directory or complete path to a file containing .fcs input of interest",
				"~/fcs/");
		c.addArgWithDefault(FCS_WSP_MAP, "a map between fcs files and manual .wsps", "map.txt");
		c.addArgWithDefault(PANEL_1_MAP, "map from automatic to manual gate scheme", "p1.map.txt");
		c.addArgWithDefault(PANEL_2_MAP, "map from automatic to manual gate scheme", "p2.map.txt");

		c.addArgWithDefault(CLI.ARG_OUTDIR, CLI.DESC_OUTDIR, "~/fcsAnalyzed/");
		c.addArgWithDefault(TEMPLATE_LYMPH, "full path to lymphocyte gating .csv template", "~/templates/lymph.csv");
		c.addArgWithDefault(TEMPLATE_MONOCYTE, "full path to monocyte gating .csv template", "~/templates/mono.csv");
		c.addArgWithDefault(CLI.ARG_THREADS, CLI.DESC_THREADS, 24);
		c.addArgWithDefault(BATCH, "number of batches to create, set to 0 to simply run", 0);
		c.addArgWithDefault(PSF.Ext.MEMORY_MB, "memory in mb if batching", PSF.Ext.DEFAULT_MEMORY_MB);
		c.addArgWithDefault(PSF.Ext.WALLTIME_HRS, "walltime in hours", 30);

		c.parseWithExit(args);
		if (c.getI(BATCH) > 0) {
			batch(c);
		} else {
			run(c);
		}
	}
}
