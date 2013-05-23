package pl.radomski.aggregation;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mongodb.AggregationOutput;

public class Support {
	private static Gson gson;

	public static String prettyPrint(AggregationOutput output) {
		if (gson == null) {
			gson = new GsonBuilder().setPrettyPrinting().disableHtmlEscaping()
					.create();
		}
		return gson.toJson(gson.fromJson(output.toString(), Object.class));
	}

	public static void saveToFile(File file, String string) {
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(file));
			out.write(string);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
