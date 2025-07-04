package model;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Mahasiswa {
    private String nim;
    private String nama;
    private double nilai;

    // Getter & Setter
    public String getNim() { return nim; }
    public void setNim(String nim) { this.nim = nim; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public double getNilai() { return nilai; }
    public void setNilai(double nilai) { this.nilai = nilai; }

    // Simpan Mahasiswa Baru
    public boolean simpan() {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO mahasiswa(nim, nama, nilai) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nim);
            ps.setString(2, nama);
            ps.setDouble(3, nilai);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update Mahasiswa
    public boolean update() {
        try (Connection conn = getConnection()) {
            String sql = "UPDATE mahasiswa SET nama=?, nilai=? WHERE nim=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nama);
            ps.setDouble(2, nilai);
            ps.setString(3, nim);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Hapus Mahasiswa
    public boolean hapus() {
        try (Connection conn = getConnection()) {
            String sql = "DELETE FROM mahasiswa WHERE nim=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, this.nim);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Baca berdasarkan NIM
    public boolean baca(String nim) {
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM mahasiswa WHERE nim=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nim);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.nim = rs.getString("nim");
                this.nama = rs.getString("nama");
                this.nilai = rs.getDouble("nilai");
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tampilkan Semua Mahasiswa
    public static List<Mahasiswa> getAllMahasiswa() {
        List<Mahasiswa> list = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM mahasiswa";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mahasiswa m = new Mahasiswa();
                m.setNim(rs.getString("nim"));
                m.setNama(rs.getString("nama"));
                m.setNilai(rs.getDouble("nilai"));
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cari Mahasiswa berdasarkan keyword
    public static List<Mahasiswa> cariMahasiswa(String keyword) {
        List<Mahasiswa> list = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM mahasiswa WHERE nim LIKE ? OR nama LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            String search = "%" + keyword + "%";
            ps.setString(1, search);
            ps.setString(2, search);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Mahasiswa m = new Mahasiswa();
                m.setNim(rs.getString("nim"));
                m.setNama(rs.getString("nama"));
                m.setNilai(rs.getDouble("nilai"));
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // === PRIVATE CONNECTION METHOD ===
    private static Connection getConnection() throws NamingException, SQLException {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mahasiswaDB");
        return ds.getConnection();
    }
}
