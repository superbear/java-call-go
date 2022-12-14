package go;

import java.io.File;

import com.sun.jna.Native;

import go.types.GoString;

public class Client {
    private static Awesome handle = null;

    static {
        try {
            File file = Native.extractFromResourcePath("awesome", Client.class.getClassLoader());
            Awesome lib = Native.load(file.getAbsolutePath(), Awesome.class);
            handle = (Awesome)Native.synchronizedLibrary(lib);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static int Add(int a, int b) {
        return handle.Add(a, b);
    }

    public static String ToUpper(String s) {
        return handle.ToUpper(new GoString(s));
    }

    public static Long Atoi(String s) {
        return handle.Atoi(new GoString(s)).getResult();
    }
}
